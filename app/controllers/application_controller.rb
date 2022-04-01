class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

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
    added_attrs = [ :name,
                    :email,
                    :password,
                    :password_confirmation,
                  ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
