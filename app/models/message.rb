class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_commit :broadcast_message, on: [:create]

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end
end
