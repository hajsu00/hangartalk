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
            fill_in 'アカウント名（任意）', with: 'test'
            fill_in 'メールアドレス *', with: 'test@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認） *', with: 'password'
            click_button '認証メールを送信する'
            expect(current_path).to eq new_user_session_path
            expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
          end
        end
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'アカウント名（任意）', with: 'test'
            fill_in 'メールアドレス *', with: nil
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認） *', with: 'password'
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Eメールを入力してください'
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'アカウント名（任意）', with: 'test'
            fill_in 'メールアドレス *', with: user.email
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認） *', with: 'password'
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Eメールはすでに存在します'
          end
        end
        context 'パスワードが未記入' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'アカウント名（任意）', with: 'test'
            fill_in 'メールアドレス *', with: user.email
            fill_in 'パスワード', with: nil
            fill_in 'パスワード（確認） *', with: nil
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'パスワードを入力してください'
          end
        end
        context 'パスワードが６文字未満かつパスワード（確認）の入力値が異常' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in 'アカウント名（任意）', with: 'test'
            fill_in 'メールアドレス *', with: user.email
            fill_in 'パスワード', with: 'aaa'
            fill_in 'パスワード（確認） *', with: 'bbb'
            click_button '認証メールを送信する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
            expect(page).to have_content 'パスワードは6文字以上で入力してください'
          end
        end
      end
    end
    # describe 'ログイン後' do
    #   let(:user) { create(:user) }
    #   let(:other_user) { create(:user) }
    #   user.confirm
    #   # before { login(user) }
    #   describe 'ユーザー編集' do
    #     context 'フォームの入力値が正常' do
    #       it 'ユーザーの編集が成功' do
    #         sign_in user
    #         visit edit_user_registration_path(user)
    #         binding.pry
    #         fill_in 'Email', with: 'test@example.com'
    #         fill_in '新しいパスワード(変更する場合のみ記入してください)', with: 'password'
    #         fill_in '新しいパスワード（確認）', with: 'password'
    #         fill_in '現在のパスワード(入力してください)', with: 'password'
    #         click_button '更新する'
    #         expect(current_path).to eq users_path
    #         expect(page).to have_content 'ユーザー情報を更新しました'
    #       end
    #     end
    #     context 'メールアドレス未記入' do

    #     end
    #   end
    # end
  end


  # describe 'user create a new account' do
  #   # context 'When valid values are entered' do
  #   #   before do
  #   #     visit login_path
  #   #     # ここに、テンプレートが表示されたことを確認するコードを入れる
  #   #     fill_in 'メールアドレス', with: 'user@example.com'
  #   #     fill_in 'パスワード', with: 'password'
  #   #     click_button 'ログイン'
  #   #   end
  #   #   it 'gets an flash message' do
  #   #     expect(page).to have_selector('.alert-success', text: 'ログインに成功しました！')
  #   #   end
  #   #   # it 'render to /users/(id) url' do
  #   #   #   expect(current_path).to eq user_path(User.last)
  #   #   # end
  #   # end
  #   context 'When invalid values are entered' do
  #     before do
  #       visit login_path
  #       # ここに、テンプレートが表示されたことを確認するコードを入れる
  #       fill_in 'メールアドレス', with: 'user@invalid'
  #       fill_in 'パスワード', with: ''
  #       click_button 'ログイン'
  #     end
  #     it 'has no flash after visiting another page' do
  #       expect(current_path).to eq login_path
  #       expect(page).to have_content 'ログインに失敗しました。入力内容を確認してください。'
  #     end
  #     it 'has no flash after visiting another page' do
  #       visit login_path
  #       expect(page).not_to have_content 'ログインに失敗しました。入力内容を確認してください。'
  #     end
  #   end
  # end
end
