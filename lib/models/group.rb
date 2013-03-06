# encoding: utf-8

class Group < ActiveRecord::Base

  attr_accessible           :name, :slug, :summary

  belongs_to                :user
  has_many                  :topics
  has_many                  :members,        :dependent => :destroy
  has_many                  :users,          :through => :members,  :source => :user

  SLUG_REGEX = /^(?:(?i)[a-z|0-9|A-Z|_|-]+)$/

  validates_presence_of     :name, :message => "小组名称不能空"
  validates_presence_of     :slug, :message => "小组代号不能为空"
  validates_uniqueness_of   :slug, :message => "小组代号已存在", :case_sensitive => false
  validates_format_of       :slug, :message => "代号只能用英文大小写字母和阿拉伯数字表示", :with => SLUG_REGEX
  validates_length_of       :slug, :too_long => "小组代号太长，不能大于25个字符", :too_short => "小组代号太短，不能小于3个字符", :within => 3..25
  validates_length_of       :name, :too_long => "小组名称太长，不能大于10个字符", :too_short => "小组名称太短，不能小于2个字符", :within => 2..10

  BLACKLIST = ["new", "list", "admin", "root", "admin",
               "administrator", "create", "sign_up",
               "sign_in", "update", "destroy", "delete",
               "redirect", "search", "find"].freeze


  before_save do
    if self.summary.blank?
      self.summary = "组长很懒没有给这个小组写点什么"
    end
  end

  validate do
    BLACKLIST.map do |bl|
      errors.add(:slug, "代号名称不合法，请更换") if slug.include?(bl)
    end
  end

end