class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.name = "#{auth.info.first_name} #{auth.info.last_name}"
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  validates :name, presence: true
         
  has_many :friend_requestings, class_name: 'Friendship', dependent: :destroy
  has_many :friend_requestings_to, class_name: 'Friendship', foreign_key: :friend, dependent: :destroy
  has_many :friendships, -> { where(accepted: true) }
  has_many :friend_requests, through: :friend_requestings, source: :friend
  has_many :friends, through: :friendships
  
  has_many :notifications, class_name: 'FriendRequestNotification', dependent: :destroy
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  after_create :welcome_email
  
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
  
  private
  
    def welcome_email
      UserMailer.welcome_email(self).deliver_now
    end
    
end
