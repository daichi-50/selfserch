class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    mount_uploader :generated_card, ImageUploader

  belongs_to :user

  require 'base64'
  require 'rmagick'
  require 'mini_magick'

      # 画像に文字を入れる
  def create_image(title:, description:)
    base_image = MiniMagick::Image.open("app/assets/images/enviroment/serch_card.png")
    base_image = base_image.combine_options do |c|
      c.resize '800x700'
    end

    #投稿された画像を合成

    result = base_image.composite(MiniMagick::Image.open("https://serchself.s3.amazonaws.com/#{self.image.file.path}")) do |config|
      config.compose 'Over'
      config.gravity 'center'
      config.geometry '+0-40'
      #binding.pry
    end
  

    cap_title = title.gsub(/[\r\n]/, "").truncate(20).scan(/.{1,20}/).join("\n")
    cap_description = description.gsub(/[\r\n]/, "").truncate(20).scan(/.{1,20}/).join("\n")

    result.combine_options do |config|
      #pry-byebug
      config.font './fonts/NotoSansJP-Bold.otf'
      config.fill 'black'
      config.gravity 'NorthWest'  #左上に合わせる
      config.pointsize 34
      config.draw "text 35, 35 '#{cap_title}'"
      config.pointsize 30
      #pry-byebug
      config.draw "text 42, 530 '#{cap_description}'"
    end

    self.generated_card = result
  end
end
