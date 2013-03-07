class AddUsersCountToGroups < ActiveRecord::Migration
  def change
    add_column  :groups, :users_count, :integer, :null => false, :default => 0
  end
end
