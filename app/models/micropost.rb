class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order('created_at DESC') }    #设定排序
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
