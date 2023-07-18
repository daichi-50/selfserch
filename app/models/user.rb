class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  validates :username, presence: true, length: { maximum: 50, allow_blank: true }


  def own?(object)
    object.user_id == id
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲスト" 
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(created_at email id money remember_created_at reset_password_sent_at updated_at username)
  end

  def self.ransackable_associations(auth_object = nil)
    %w(favorite_posts favorites messages posts)
  end
end
