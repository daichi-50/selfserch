class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :username, presence: true, length: { maximum: 50, allow_blank: true }
  validates :email, presence: true, uniqueness: true

  def own?(object)
    object.user_id == id
  end
end
