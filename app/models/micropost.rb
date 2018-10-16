class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order('created_at DESC') }    #设定排序
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

# Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    #followed_user_ids = user.followed_user_ids
    followed_user_ids = "SELECT followed_id FROM relationships
WHERE follower_id = :user_id"
    #where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
    #where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          #followed_user_ids: followed_user_ids, user_id: user))
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
