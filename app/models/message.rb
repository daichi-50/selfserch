class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create_commit { MessageBroadcastJob.perform_later self }

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
end
