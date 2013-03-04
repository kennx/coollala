class Topics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string      :title,     :null => false
      t.text        :body,      :null => false, :default => ''
      t.integer     :user_id,   :null => false
      t.integer     :group_id,  :null => false
      t.timestamps
    end
    execute "ALTER TABLE topics AUTO_INCREMENT = 10000;"
  end
end
