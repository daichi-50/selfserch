class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :generated_card, GeneratedCardUploader

  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :image, presence: true
  validates :title, length: { maximum: 10, minimum: 1 }
  validates :description, length: { maximum: 65, minimum: 1 }

  require 'base64'
  require 'rmagick'
  require 'mini_magick'

  # 画像に文字を入れる
  def create_image
    return unless image.present?

    base_image = MiniMagick::Image.open('app/assets/images/enviroment/serch_card.png')
    base_image = base_image.combine_options do |c|
      c.resize '800x700'
    end

    # 投稿された画像を合成

    result = base_image.composite(MiniMagick::Image.open("https://serchself.s3.amazonaws.com/#{image.file.path}")) do |config|
      config.compose 'Over'
      config.gravity 'center'
      config.geometry '+0-100'
      # binding.pry
    end

    cap_title = title.gsub(/[\r\n]/, '').truncate(20).scan(/.{1,20}/).join("\n")
    cap_description = add_line_breaks(description, 13)

    result.combine_options do |config|
      # pry-byebug
      config.font 'app/assets/fonts/craft/craftmincho.otf'
      config.fill 'black'
      config.gravity 'center' # 中央に合わせる
      config.pointsize 40
      config.draw "text 0, -260 '#{escape_text(cap_title)}'"
      config.pointsize 30
      # pry-byebug
      config.draw "text 0, 120 '#{escape_text(cap_description)}'"
      config.pointsize 35
      config.draw "text 0, 320 '#{prize_money}'"
    end

    self.generated_card = result
  end

  def add_line_breaks(body, n = 13)
    broken_lines = body.split(/[\r\n]/).flat_map do |line|
      line.scan(/.{1,#{n}}/)
    end
    broken_lines[0..4].join("\n")
  end

  def escape_text(text)
    text.gsub("'", "\\\\'") # replace ' with \'
  end

  # 懸賞金の設定
  def set_prize_money
    count = 0
    polite_words = %w[です ます ございます 自分 私 僕 俺 おれ わたし あ い う え お]
    polite_words.each do |word|
      count += title.scan(word).count if title
      count += description.scan(word).count if description
    end
    self.prize_money = 100_000 + count * 100_000
  end

  # ransackの検索対象カラムを設定
  def self.ransackable_attributes(_auth_object = nil)
    %w[description prize_money title]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user favorites messages]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title content description image created_at updated_at]
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) + ['prize_money']
  end
end
