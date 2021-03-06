# encoding: utf-8

require 'digest/sha2'

class User < ActiveRecord::Base

  attr_accessible               :name, :email, :password, :password_confirmation

  has_many                      :replies
  has_many                      :topics
  has_many                      :members,        :dependent => :destroy
  has_many                      :groups,         :through => :members, :source => :group

  EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  validates_presence_of         :name,            :message => "用户名不能为空"
  validates_presence_of         :email,           :message => "邮箱地址不能为空"
  validates_uniqueness_of       :name,            :message => "该用户名已存在，请使用其他用户名", :case_sensitive => false
  validates_uniqueness_of       :email,           :message => "该邮箱地址已被注册，请使用其他邮箱", :case_sensitive => false
  validates_confirmation_of     :password,        :message => "二次密码输入不一致"
  validates_length_of           :name,            :message => "用户名必须为大于3位小于等于15位", :within => 3...15
  validates_length_of           :password,        :message => "密码长度必须为大于5位小于等于20位", :within => 5...20
  validates_format_of           :email,           :message => "邮箱地址格式有误，请检查", :with => EMAIL_REGEX

  scope :recent_members, lambda {limit(10).order("created_at DESC")}

  before_create do
    self.auth_token = SecureRandom.hex(5) + Time.now.to_i.to_s
  end

  def has_join?(slug)
    groups.includes(:members).find_by_slug(slug)
  end

  def after_login_update(req)
    self.last_login_at = Time.now
    self.last_login_ip = req
    self.save(:validate => false)
    User.increment_counter(:sign_in_count, self.id)
  end

  def self.authentication(name, password)
    user = self.find_by_name(name, password)
    if user
      if user.encrypted_password != generate_encrypted_password(password, user.salt)
        user = nil
      end
      user
    end
  end

  def is_author?(topic_id)
    topics.where(:user_id => self.id,
    :id => topic_id).limit(1).present?
  end



  def password
    @password
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.encrypted_password = User.generate_encrypted_password(password, salt)
    end
  end

  def is_admin?
    self.admin
  end

  private
  def generate_salt
    mixin_str = SecureRandom.hex(8) + self.name + rand.to_s
    self.salt = mixin_str
  end

  def self.generate_encrypted_password(password, salt)
    Digest::SHA2.hexdigest(password.to_s + salt.to_s)
  end

end