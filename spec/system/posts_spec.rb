require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:post_create_user){ create(:user) }
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
  end
    describe "手配書作成" do
      context "有効な値を入力したとき" do
        it "手配書作成が成功する" do
          sign_in @user
          visit new_post_path

          attach_file "画像", Rails.root.join('spec/fixtures/test_image.png')
          fill_in "探しもの", with: "test_title"
          fill_in "詳細", with: "test_description"
          click_button "投稿する"

          expect(page).to have_current_path(posts_path)
          expect(page).to have_content (post.user.username)
        end
      end
      context "画像が未選択のとき" do
        it "手配書作成が失敗する" do
          sign_in @user
          visit new_post_path

          fill_in "探しもの", with: "test_title"
          fill_in "詳細", with: "test_description"
          click_button "投稿する"

          expect(page).to have_current_path(new_post_path)
        end
      end
    end
  end