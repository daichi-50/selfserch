class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    mount_uploader :generated_card, ImageUploader

  belongs_to :user

  require 'base64'
  require 'rmagic'
  require 'mini_magick'

  def self.create_image(lost_item_category:)
    base_image = MiniMagick::Image.open("app/assets/images/lost_item_template.png")

    cap_lost_item_category = lost_item_category.gsub(/[\r\n]/, "").truncate(20).scan(/.{1,20}/).join("\n")

    draw = Magick::Draw.new do
      self.gravity = Magick::CenterGravity
    end

    draw.annotate(base_image, 0, 0, 75, 75, cap_title) do
      self.font = './fonts/NotoSansJP-Bold.otf'
      self.pointsize = 20
    end

    base_image.write('.images/output.png') # 画像を見ながら調整
end
