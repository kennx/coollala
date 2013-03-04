# encoding: utf-8
class Topic < ActiveRecord::Base
  belongs_to  :user,  :counter_cache => true
  belongs_to  :group, :counter_cache => true
  has_many    :replies
  validates_presence_of     :title, :message => "话题标题不能为空"
  validates_presence_of     :body,  :message => "话题内容不能为空"
  scope :explore, lambda {includes(:group, :user).order("IFNULL(replied_at, created_at) DESC")}
  scope :recent,  lambda {includes(:user).order("created_at DESC")}

  def update_replied_at(reply)
    self.replied_at = reply.created_at
    self.save
  end

  def last_replied_by
    replies.order("id DESC").limit(1).first
  end

  def has_replied?
    replies_count > 0
  end

end