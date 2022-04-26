require 'rails_helper'

RSpec.describe 'users', type: :system do
  # describe 'user create a new account' do
  #   context 'When valid values are entered' do
  #     before do
  #       visit signup_path
  #       fill_in '名前', with: 'Example User'
  #       fill_in 'メールアドレス', with: 'user@example.com'
  #       fill_in 'パスワード', with: 'password'
  #       fill_in 'パスワード（確認）', with: 'password'
  #       click_button '認証メールを送信する'
  #     end
  #     it 'gets an flash message' do
  #       expect(page).to have_selector('.alert-success', text: 'ユーザー登録に成功しました！')
  #     end
  #     it 'render to /users/(id) url' do
  #       expect(current_path).to eq user_path(User.last)
  #     end
  #   end
  #   context 'When invalid values are entered' do
  #     before do
  #       visit signup_path
  #       fill_in '名前', with: ''
  #       fill_in 'メールアドレス', with: 'user@invalid'
  #       fill_in 'パスワード', with: ''
  #       fill_in 'パスワード（確認）', with: ''
  #       click_button '認証メールを送信する'
  #     end
  #     subject { page }
  #     it 'gets an errors' do
  #       is_expected.to have_selector('.alert-danger', text: 'ユーザー登録に失敗しました。入力内容を確認してください。')
  #     end
  #     it 'render to /signup url' do
  #       is_expected.to have_current_path new_user_path
  #     end
  #   end
  # end
end
