class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :likers, through: :likes, source: :user
  has_many :comments
  
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 140 }
  
  default_scope -> { order(created_at: :desc) }
end
