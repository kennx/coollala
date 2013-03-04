class AddCounterCacheToTopicsAndUsers < ActiveRecord::Migration
  def change
    add_column :topics, :replies_count, :integer, :null => false, :default => 0
    add_column :users,  :replies_count, :integer, :null => false, :default => 0
  end
end
