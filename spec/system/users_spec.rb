require 'rails_helper'

RSpec.describe "UserRegistrations", type: :system do
    before do
    driven_by(:rack_test)
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
                FactoryBot.create(:user)
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
            
                fill_in 'メールアドレス', with: 'new_user@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'ログイン'
            
                expect(page).to have_current_path(new_user_session_path) # ログイン後のリダイレクト先を確認します。
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
end