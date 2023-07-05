require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }
  before { sign_in user }
    describe "手配書作成" do
      context "有効な値を入力したとき" do
        it "手配書作成が成功する" do
          visit new_post_path

          attach_file "画像", Rails.root.join('spec/fixtures/test_image.png')
          fill_in "探しもの", with: "test_title"
          fill_in "詳細", with: "test_description"
          click_button "投稿する"

          expect(page).to have_current_path(posts_path)
          expect(page).to have_content ("手配書を作成しました")
        end
      end
      context "画像が未選択のとき" do
        it "手配書作成が失敗する" do
          visit new_post_path

          fill_in "探しもの", with: "test_title"
          fill_in "詳細", with: "test_description"
          click_button "投稿する"

          expect(page).to have_content ("画像を入力してください")
        end
      end
      context "探しものが未入力のとき" do
        it "手配書作成が失敗する" do
          visit new_post_path

          attach_file "画像", Rails.root.join('spec/fixtures/test_image.png')
          fill_in "詳細", with: "test_description"
          click_button "投稿する"

          expect(page).to have_content ("探しものは1文字以上で入力してください")
        end
      end
      context "詳細が未入力のとき" do
        it "手配書作成が失敗する" do
          visit new_post_path

          attach_file "画像", Rails.root.join('spec/fixtures/test_image.png')
          fill_in "探しもの", with: "test_title"
          click_button "投稿する"

          expect(page).to have_content ("詳細は1文字以上で入力してください")
        end
      end
    end
    describe "手配書の閲覧" do
      let(:post) do 
        user.posts.create!(
          :title => "test_title",
          :description => "test_description",
          :image => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.png'), 'image/png'),
          :prize_money => 1000,
          :generated_card => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_card_image.png'), 'image/png')
        )
      end
      context "手配書詳細画面に遷移したとき" do
        it "手配書詳細画面に遷移する" do
          visit post_path(post)

          expect(page).to have_current_path(post_path(post))
          expect(page).to have_content ("削除")
        end
      end
      context "手配書詳細画面で削除ボタンを押したとき" do
        it "手配書が削除される" do
          visit post_path(post)

          click_on "削除"

          expect(page).to have_current_path(posts_path)
          expect(page).to have_content ("手配書を削除しました")
        end
      end
    end
  end