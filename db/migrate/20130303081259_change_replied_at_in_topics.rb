class ChangeRepliedAtInTopics < ActiveRecord::Migration
  def change
    change_column   :topics, :replied_at, :datetime, :null => true, :default => nil
  end
end
