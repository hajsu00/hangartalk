class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless user_signed_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to user_session_url
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :encrypted_password])
  end
end
