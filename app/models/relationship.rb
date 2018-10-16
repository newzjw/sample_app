class Relationship < ApplicationRecord
  # 因为follower模型和followed模型是不存在的，因此这里要用User这个类名
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
