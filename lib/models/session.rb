# encoding: utf-8
class Session
  include ActiveModel::Validations
  validates_presence_of :username, :message => '用户名不能为空'
  validates_presence_of :password, :message => '密码不能为空'

  attr_accessor :username, :password

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

end