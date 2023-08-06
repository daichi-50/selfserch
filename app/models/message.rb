class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_commit :broadcast_message, on: [:create]
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at id post_id updated_at user_id]
  end
end
