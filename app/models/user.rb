class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :friend_requestings, class_name: 'Friendship'
  has_many :friendships, -> { where(accepted: true) }
  has_many :friend_requests, through: :friend_requestings, source: :friend
  has_many :friends, through: :friendships
  
  has_many :notifications, class_name: 'FriendRequestNotification', dependent: :destroy
  
  has_many :posts
  has_many :comments
  
  def friends_with? other
    friends.include?(other)
  end

  def request_sent_to? other
    friend_requests.include? other
  end
  
  def request_from? other
    other.friend_requests.include? self
  end
  
  def add_friend other
    if request_from? other
      friends << other
      other.friend_request_to(self).update(accepted: true)
    else
      friend_requests << other
      other.notifications.create!(friendship_id: friend_request_to(other).id)
    end
  end
  
  def remove_friend other
    if friends_with? other
      other.friends.destroy self
    end
    friend_requests.destroy other
  end
  
  # Returns a user's status feed.
  def feed
    following_ids = "SELECT friend_id FROM friendships
                     WHERE  user_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id",
                    user_id: id)
  end
  
  protected
  
    def friend_request_to other
      friend_requestings.where(friend_id: other.id).first
    end
  
end
