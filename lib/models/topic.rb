# encoding: utf-8

class Topic < ActiveRecord::Base

  attr_accessible           :title, :body

  belongs_to                :user,  :counter_cache => true
  belongs_to                :group, :counter_cache => true
  has_many                  :replies

  validates_presence_of     :title, :message => "话题标题不能为空"
  validates_presence_of     :body,  :message => "话题内容不能为空"

  scope :explore,        lambda { includes(:group, :user).order("IFNULL(replied_at, created_at) DESC").where(:status => [0, 1]) }
  scope :recent,         lambda { includes(:user).order("created_at DESC").where(:status => [0, 1]) }
  scope :visible_status, lambda { where(:status => [0, 1]) }
  
  STATUS = ["正常", "锁定", "回收"].freeze



  def has_locked?
    STATUS[status] == STATUS[1]
  end

  def is_trash?
    STATUS[status] == STATUS[2]
  end

  def is_not_normal?
    !has_locked? || !is_trash?
  end

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