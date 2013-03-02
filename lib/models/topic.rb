# encoding: utf-8
class Topic < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :group
  validates_presence_of     :title, :message => "话题标题不能为空"
  validates_presence_of     :body,  :message => "话题内容不能为空"
end