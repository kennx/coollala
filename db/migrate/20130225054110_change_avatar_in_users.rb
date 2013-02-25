class ChangeAvatarInUsers < ActiveRecord::Migration
  def change
    change_column :users, :avatar, :string, :null => false, :default => "default.gif"
  end
end
