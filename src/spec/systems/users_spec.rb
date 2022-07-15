require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'User CRUD' do
    describe 'ログイン前' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            visit new_user_registration_path
            fill_in 'user[name]', with: 'test'
            fill_in 'user[email]', with: 'test@example.com'
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '認証メールを送信する'
            expect(current_path).to eq new_user_session_path
            expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
          end
        end
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user[name]', with: 'test'
            fill_in 'user[email]', with: nil
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Eメールを入力してください'
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user[name]', with: 'test'
            fill_in 'user[email]', with: user.email
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Eメールはすでに存在します'
          end
        end
        context 'パスワードが未記入' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user[name]', with: 'test'
            fill_in 'user[email]', with: user.email
            fill_in 'user[password]', with: nil
            fill_in 'user[password_confirmation]', with: nil
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'パスワードを入力してください'
          end
        end
        context 'パスワードが６文字未満かつパスワード（確認）の入力値が異常' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'user[name]', with: 'test'
            fill_in 'user[email]', with: user.email
            fill_in 'user[password]', with: 'aaa'
            fill_in 'user[password_confirmation]', with: 'bbb'
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
            expect(page).to have_content 'パスワードは6文字以上で入力してください'
          end
        end
      end
    end
  end
end