# require 'rails_helper'

# RSpec.describe "UserAuthentications", type: :request do
#   let(:user) { create(:user) }
#   let(:user_params) { attributes_for(:user) }
#   let(:invalid_user_params) { attributes_for(:user, email: "aaa", password: "aaa", password_confirmation: "bbb") }

#   describe 'POST #sign_up' do
#     before do
#       ActionMailer::Base.deliveries.clear # ActionMailer::Base.deliveriesという配列をクリアしている。認証メールが絡むテストでは必要。
#     end
#     context 'パラメータが正しい場合' do
#       it 'リクエストが成功すること' do
#         post user_registration_path, params: { user: user_params }
#         expect(response.status).to eq 302
#       end

#       it 'ユーザー登録が成功すること' do
#         expect do
#           post user_registration_path, params: { user: user_params }
#         end.to change { User.count }.by 1
#       end

#       it '認証メールが送信されること' do
#         post user_registration_path, params: { user: user_params }
#         expect(ActionMailer::Base.deliveries.size).to eq 1
#       end

#       it 'ログインページにリダイレクトされること（メール認証のため）' do
#         post user_registration_path, params: { user: user_params }
#         expect(response).to redirect_to new_user_session_url
#       end

#       it 'ユーザーが無効であること' do
#         post user_registration_path, params: { user: user_params }
#         expect(user.admin).to eq false
#       end
#     end

#     context 'パラメータが不正な場合' do
#       it 'リクエストが成功すること' do
#         post user_registration_path, params: { user: invalid_user_params }
#         expect(response.status).to eq 200
#       end

#       it 'ユーザー登録が失敗すること' do
#         expect do
#           post user_registration_path, params: { user: invalid_user_params }
#         end.to change { User.count }.by 0
#       end

#       it '認証メールが送信されないこと' do
#         post user_registration_path, params: { user: invalid_user_params }
#         expect(ActionMailer::Base.deliveries.size).to eq 0
#       end

#       it 'エラーが表示されること' do
#         post user_registration_path, params: { user: invalid_user_params }
#         expect(response.body).to include 'Eメールは不正な値です'
#         expect(response.body).to include 'パスワード（確認用）とパスワードの入力が一致しません'
#         expect(response.body).to include 'パスワードは6文字以上で入力してください'
#       end
#     end
#   end
# end
