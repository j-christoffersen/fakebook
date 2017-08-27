class CreateFriendRequestNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_request_notifications do |t|
      t.references :friendship, foreign_key: true, on_delete: :cascade
      t.references :user, foreign_key: true
      t.boolean :seen, default: false

      t.timestamps
    end
    add_index :friend_request_notifications, :created_at
  end
end
