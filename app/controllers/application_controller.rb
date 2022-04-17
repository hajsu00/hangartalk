class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # サイドバー用のデータをセットする
  def set_sideber_data
    @current_user = current_user
    @glider_flights = @current_user.glider_flights.where("user_id = ?", current_user.id).order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

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
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  end
end
