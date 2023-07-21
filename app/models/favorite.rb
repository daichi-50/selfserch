class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id post_id updated_at user_id]
  end
end
