class AddTopicsCountToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :topics_count, :integer, :null => false, :default => 0
  end
end
