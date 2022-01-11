require 'rails_helper'

RSpec.describe 'users', type: :system do
  describe 'user create a new account' do
    # context 'When valid values are entered' do
    #   before do
    #     visit login_path
    #     # ここに、テンプレートが表示されたことを確認するコードを入れる
    #     fill_in 'メールアドレス', with: 'user@example.com'
    #     fill_in 'パスワード', with: 'password'
    #     click_button '認証メールを送信する'
    #   end
    #   it 'gets an flash message' do
    #     expect(page).to have_selector('.alert-success', text: 'ログインに成功しました！')
    #   end
    #   # it 'render to /users/(id) url' do
    #   #   expect(current_path).to eq user_path(User.last)
    #   # end
    # end
    context 'When invalid values are entered' do
      before do
        visit login_path
        # ここに、テンプレートが表示されたことを確認するコードを入れる
        fill_in 'メールアドレス', with: 'user@invalid'
        fill_in 'パスワード', with: ''
        click_button '認証メールを送信する'
      end
      it 'has no flash after visiting another page' do
        expect(current_path).to eq login_path
        expect(flash.empty?).to be false
        visit login_path
        expect(flash.empty?).to be true
      end
      # subject { page }
      # it 'gets an errors' do
      #   is_expected.to have_selector('.alert-danger', text: 'ログインに失敗しました。入力内容を確認してください。')
      # end
      # it 'render to /signup url' do
      #   is_expected.to have_current_path login_path
      # end
    end
  end
end
