# encoding: utf-8
class Group < ActiveRecord::Base
  SLUG_REGEX = /^(?:(?i)[a-z|0-9|A-Z|_|-]+)$/
  validates_presence_of     :name, :message => "小组名称不能空"
  validates_presence_of     :slug, :message => "小组代号不能为空"
  validates_uniqueness_of   :slug, :message => "小组代号已存在"
  validates_format_of       :slug, :with => SLUG_REGEX, :message => "代号只能用英文大小写字母和阿拉伯数字表示"

  before_save do
    if self.summary.blank?
      self.summary = "组长很懒没有给这个小组写点什么"
    end
  end

end