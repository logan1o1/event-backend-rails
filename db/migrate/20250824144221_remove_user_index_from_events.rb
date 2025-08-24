class RemoveUserIndexFromEvents < ActiveRecord::Migration[8.0]
  def change
    remove_index :events, name: "index_events_on_user_id"
  end
end
