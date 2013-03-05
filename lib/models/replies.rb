# encoding: utf-8

class Reply < ActiveRecord::Base
  attr_accessible              :title, :body

  belongs_to                   :user,    :counter_cache => true
  belongs_to                   :topic,   :counter_cache => true
  validates_presence_of        :body,  :message => "回复内容不能空"

  scope :sort_desc, lambda {includes(:user)}

  after_create :update_topic_replied_at

  def update_topic_replied_at
    topic.update_replied_at(self)
  end

  before_create :add_topic_title
  def add_topic_title
    if self.title.blank?
      self.title = "[回复话题]" + self.topic.title
    end
  end

end