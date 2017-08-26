class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :friendships
  has_many :friends, through: :friendships
  
  def friends_with? other
    friends.include? other
  end
  
  def add_friend other
    friends << other
    other.friends << self
  end
  
  def remove_friend other
    friends.delete other
    other.friends.delete self
  end
  
end
