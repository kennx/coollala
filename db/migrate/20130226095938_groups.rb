class Groups < ActiveRecord::Migration
  def change
    create_table  :groups do |t|
      t.string    :name,    :null => false
      t.text      :summary, :null => false, :default => ""
      t.string    :slug,    :null => false
      t.timestamps
    end
  end
end
