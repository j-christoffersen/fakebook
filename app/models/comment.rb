class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  validate :friendly_post
  
  default_scope -> { order(created_at: :asc) }
  
  def friendly_post
    unless (user.friends.all.include? post.user) || (user == post.user)
      errors.add(:post_id, "you can only comment on friends posts")
      return false
    else
      return true
    end
  end
end
