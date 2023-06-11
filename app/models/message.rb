class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
end
