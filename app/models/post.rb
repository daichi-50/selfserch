class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    mount_uploader :generated_card, GeneratedCardUploader

  belongs_to :user

  require 'base64'
  require 'rmagick'
  require 'mini_magick'

      # 画像に文字を入れる
  def create_image
    base_image = MiniMagick::Image.open("app/assets/images/enviroment/serch_card.png")
    base_image = base_image.combine_options do |c|
      c.resize '800x700'
    end

    #投稿された画像を合成

    result = base_image.composite(MiniMagick::Image.open("https://serchself.s3.amazonaws.com/#{self.image.file.path}")) do |config|
      config.compose 'Over'
      config.gravity 'center'
      config.geometry '+0-100'
      #binding.pry
    end

    cap_title = title.gsub(/[\r\n]/, "").truncate(20).scan(/.{1,20}/).join("\n")
    cap_description = add_line_breaks(description, 13)

    result.combine_options do |config|
      #pry-byebug
      config.font 'app/assets/fonts/craft/craftmincho.otf'
      config.fill 'black'
      config.gravity 'center'  #中央に合わせる
      config.pointsize 40
      config.draw "text 0, -260 '#{escape_text(cap_title)}'"
      config.pointsize 30
      #pry-byebug
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
    text.gsub("'", "\\\\'")  # replace ' with \'
  end
end
