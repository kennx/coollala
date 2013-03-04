class Replies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string  :title,     :null => false, :default => ""
      t.text    :body,      :null => false
      t.integer :user_id,   :null => false
      t.integer :group_id,  :null => false
      t.timestamps
    end
  end
end
