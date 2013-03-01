class AddUserToToGroups < ActiveRecord::Migration
  def change
    add_column      :groups,      :user_id,     :integer,   :null => false
  end
end
