# encoding: utf-8

class Member < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :group,       :counter_cache => :users_count
  validates_uniqueness_of   :group_id, :scope => :user_id

end