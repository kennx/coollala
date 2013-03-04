class ChangeGroupIdInReplies < ActiveRecord::Migration
  def change
    rename_column   :replies, :group_id, :topic_id
  end
end
