require 'rails_helper'

RSpec.describe 'UserRegistrations', type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
  end
  describe 'ユーザー登録' do
    context '有効な値を入力したとき' do
      it 'ユーザー登録が成功する' do
        visit new_user_registration_path

        fill_in '名前', with: 'new_user'
        fill_in 'メールアドレス', with: 'new_user@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '会員登録'

        expect(page).to have_current_path(posts_path) # 登録後のリダイレクト先を確認します。
      end
    end
    context '名前が未入力' do
      it 'ユーザー登録が失敗する' do
        visit new_user_registration_path

        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: 'new_user@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '会員登録'

        expect(page).to have_current_path(user_registration_path) # 登録失敗後は同じページに戻るはずです。
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザー登録が失敗する' do
        visit new_user_registration_path

        fill_in '名前', with: 'new_user'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '会員登録'

        expect(page).to have_current_path(user_registration_path) # 登録失敗後は同じページに戻るはずです。
      end
    end

    context '登録済みのメールアドレスを入力したとき' do
      it 'ユーザー登録が失敗する' do
        visit new_user_registration_path

        fill_in '名前', with: 'new_user'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '会員登録'

        expect(page).to have_current_path(user_registration_path) # 登録失敗後は同じページに戻るはずです。
      end
    end
  end

  describe 'ユーザーログイン' do
    context '有効な値を入力したとき' do
      it 'ログインが成功する' do
        visit new_user_session_path

        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'

        expect(page).to have_current_path(posts_path) # ログイン後のリダイレクト先を確認します。
      end

      it 'ログインが失敗する' do
        visit new_user_session_path

        fill_in 'メールアドレス', with: 'new_user@example.com'
        fill_in 'パスワード', with: ''
        click_button 'ログイン'

        expect(page).to have_current_path(new_user_session_path) # ログイン失敗後は同じページに戻るはずです。
      end
    end
  end

  describe 'ユーザーログアウト' do
    context 'ログインしているとき' do
      it 'ログアウトが成功する' do
        sign_in @user
        visit posts_path
        click_link 'ログアウト'
        expect(page).to have_current_path(root_path) # ログアウト後のリダイレクト先を確認します。
      end
    end
  end

  describe 'ユーザー詳細' do
    context 'ログインしているとき' do
      it 'ユーザー詳細ページが表示される' do
        sign_in @user
        visit user_path(@user)
        expect(page).to have_current_path(user_path(@user)) # ログアウト後のリダイレクト先を確認します。
        expect(page).to have_content(@user.username)
      end
    end
    context 'ログインしていないとき' do
      it 'ユーザー詳細ページが表示されない' do
        visit user_path(@user)
        expect(page).to have_current_path(new_user_session_path) # ログアウト後のリダイレクト先を確認します。
      end
    end
  end

  describe 'ランキングの閲覧' do
    context 'ログインしているとき' do
      it 'ランキングページが表示される' do
        sign_in @user
        visit users_path
        expect(page).to have_current_path(users_path) # ランキングページが表示されるはずです。
      end
    end
    context 'ログインしていないとき' do
      it 'ランキングページが表示されない' do
        visit users_path
        expect(page).to have_current_path(new_user_session_path) # ランキングページが表示されないはずです。
      end
    end
  end
end
