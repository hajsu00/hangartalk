require 'rails_helper'

RSpec.describe 'Sign up', type: :system do
  context 'when invalid terms are posted' do
    # let(:user_params) do
    #   attributes_for(:user, name: '', email: 'user@invalid', password: '', password_confirmation: '')
    # end
    it 'has no change in number of user' do
      #visit signup_path
      expect do
        post users_path, params: { user: { name: '', email: 'user@invalid', password: '', password_confirmation: '' } }
      end.to change{ User.count }.by(0)
      expect(current_path).to eq signup_path
    end
  end
  context 'when valid terms are posted' do
    # let(:user_params) do
    #   attributes_for(:user, name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    # end
    before do
      @user = { name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password' }
    end
    it 'has no change in number of user' do
      #visit signup_path
      expect do
        # post users_path, params: { user: { name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password' } }
        post users_path, params: { user: @user }
      end.to change{ User.count }.by(1)
      expect(response).to redirect_to user_path(@user)
    end
  end
end
