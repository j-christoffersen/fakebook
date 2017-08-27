class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_one :reciprocal, class_name: "Friendship"
  has_many :notifications, class_name: 'FriendRequestNotification', dependent: :destroy
end
