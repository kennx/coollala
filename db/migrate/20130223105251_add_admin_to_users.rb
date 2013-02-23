class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column    :users, :admin, :boolean, :null => false, :default => 0
  end
  execute "ALTER TABLE users AUTO_INCREMENT = 1000;"
end
