class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :post_id, presence: true
  validates :user_id, presence: true
  
  validate :friendly_post
  
  def friendly_post
    unless (user.friends.all.include? post.user) || (user == post.user)
      errors.add(:post_id, "you can only comment on friends posts")
      return false
    else
      return true
    end
  end
end
