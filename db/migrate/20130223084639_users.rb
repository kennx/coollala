class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string        :name,                 :null => false
      t.string        :email,                :null => false
      t.string        :encrypted_password,   :null => false
      t.string        :salt,                 :null => false
      t.integer       :sign_in_count,        :default => 0
      t.timestamps
    end
  end
end
