class AddLastLoginAtAndLastLoginIpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login_at, :datetime, :null => false, :default => Time.now
    add_column :users, :last_login_ip, :string,   :null => false, :default => "0.0.0.0"
  end
end
