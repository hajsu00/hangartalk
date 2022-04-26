class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_glider_flight_selectors
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  # サイドバー用のデータをセットする
  def set_sideber_data
    @current_user = User.find(current_user.id)
    initial_flight_log = @current_user.glider_initial_log
    @initial_flight_time = initial_flight_log.non_power_total_time
    @initial_flight_number = initial_flight_log.non_power_total_number
    @all_glider_flights = @current_user.glider_flights
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
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avatar, :user_cover])
  end
end
