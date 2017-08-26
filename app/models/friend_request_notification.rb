class FriendRequestNotification < ApplicationRecord
  belongs_to :friendship
  belongs_to :user, foreign_key: :notification
end
