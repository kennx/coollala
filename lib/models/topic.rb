# encoding: utf-8
class Topic < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :group, :counter_cache => true
  validates_presence_of     :title, :message => "话题标题不能为空"
  validates_presence_of     :body,  :message => "话题内容不能为空"
  scope :explore, lambda {includes(:group, :user).order("created_at DESC")}
  scope :recent,  lambda {includes(:user).order("created_at DESC")}
end