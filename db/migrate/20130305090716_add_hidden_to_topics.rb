class AddHiddenToTopics < ActiveRecord::Migration
  def change
    add_column  :topics, :status, :integer, :null => false, :default => 0
  end
end
