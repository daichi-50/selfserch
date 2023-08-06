class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :post, optional: true
  belongs_to :message, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  validates :action, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id post_id updated_at visited_id visitor_id]
  end
end
