class GliderInitialLogsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @glider_initial_log = current_user.build_glider_initial_log
  end

  def create
    @glider_initial_log = current_user.build_glider_initial_log(glider_initial_log_params)
    if @glider_initial_log.save
      flash[:success] = "過去ログの登録に成功しました！"
      redirect_to glider_flights_url
    else
      flash[:danger] = "過去ログの登録に失敗しました"
      render 'static_pages/top'
    end
  end

  def show
    @glider_initial_log = current_user.glider_initial_log
  end

  def edit
    @glider_initial_log = current_user.glider_initial_log
  end

  def update
    @glider_initial_log = current_user.glider_initial_log
    if @glider_initial_log.update(glider_initial_log_params)
      flash[:success] = "フライトログの更新に成功しました！"
      redirect_to glider_initial_log_url
    else
      flash[:danger] = "フライトログの更新に失敗しました。"
      render 'glider_initial_log/edit'
    end
  end

  def destroy
    @glider_initial_log.destroy
    current_user.reload_glider_initial_log
    flash[:success] = "過去のフライトログを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

  def glider_initial_log_params
    # 入力がnilの場合は0を代入
    params[:glider_initial_log][:non_power_total_time] = 0 if params[:glider_initial_log][:non_power_total_time].empty?
    params[:glider_initial_log][:non_power_total_number] = 0 if params[:glider_initial_log][:non_power_total_number].empty?
    params[:glider_initial_log][:pic_winch_time] = 0 if params[:glider_initial_log][:pic_winch_time].empty?
    params[:glider_initial_log][:pic_winch_number] = 0 if params[:glider_initial_log][:pic_winch_number].empty?
    params[:glider_initial_log][:pic_aero_tow_time] = 0 if params[:glider_initial_log][:pic_aero_tow_time].empty?
    params[:glider_initial_log][:pic_aero_tow_number] = 0 if params[:glider_initial_log][:pic_aero_tow_number].empty?
    params[:glider_initial_log][:solo_winch_time] = 0 if params[:glider_initial_log][:solo_winch_time].empty?
    params[:glider_initial_log][:solo_winch_number] = 0 if params[:glider_initial_log][:solo_winch_number].empty?
    params[:glider_initial_log][:solo_aero_tow_time] = 0 if params[:glider_initial_log][:solo_aero_tow_time].empty?
    params[:glider_initial_log][:solo_aero_tow_number] = 0 if params[:glider_initial_log][:solo_aero_tow_number].empty?
    params[:glider_initial_log][:dual_winch_time] = 0 if params[:glider_initial_log][:dual_winch_time].empty?
    params[:glider_initial_log][:dual_winch_number] = 0 if params[:glider_initial_log][:dual_winch_number].empty?
    params[:glider_initial_log][:dual_aero_tow_time] = 0 if params[:glider_initial_log][:dual_aero_tow_time].empty?
    params[:glider_initial_log][:dual_aero_tow_number] = 0 if params[:glider_initial_log][:dual_aero_tow_number].empty?
    params[:glider_initial_log][:power_total_time] = 0 if params[:glider_initial_log][:power_total_time].empty?
    params[:glider_initial_log][:power_total_number] = 0 if params[:glider_initial_log][:power_total_number].empty?
    params[:glider_initial_log][:pic_power_time] = 0 if params[:glider_initial_log][:pic_power_time].empty?
    params[:glider_initial_log][:pic_power_number] = 0 if params[:glider_initial_log][:pic_power_number].empty?
    params[:glider_initial_log][:pic_power_off_time] = 0 if params[:glider_initial_log][:pic_power_off_time].empty?
    params[:glider_initial_log][:pic_power_off_number] = 0 if params[:glider_initial_log][:pic_power_off_number].empty?
    params[:glider_initial_log][:solo_power_time] = 0 if params[:glider_initial_log][:solo_power_time].empty?
    params[:glider_initial_log][:solo_power_number] = 0 if params[:glider_initial_log][:solo_power_number].empty?
    params[:glider_initial_log][:solo_power_off_time] = 0 if params[:glider_initial_log][:solo_power_off_time].empty?
    params[:glider_initial_log][:solo_power_off_number] = 0 if params[:glider_initial_log][:solo_power_off_number].empty?
    params[:glider_initial_log][:dual_power_time] = 0 if params[:glider_initial_log][:dual_power_time].empty?
    params[:glider_initial_log][:dual_power_number] = 0 if params[:glider_initial_log][:dual_power_number].empty?
    params[:glider_initial_log][:dual_power_off_time] = 0 if params[:glider_initial_log][:dual_power_off_time].empty?
    params[:glider_initial_log][:dual_power_off_number] = 0 if params[:glider_initial_log][:dual_power_off_number].empty?
    params[:glider_initial_log][:cross_country_time] = 0 if params[:glider_initial_log][:cross_country_time].empty?
    params[:glider_initial_log][:instructor_time] = 0 if params[:glider_initial_log][:instructor_time].empty?
    params[:glider_initial_log][:instructor_number] = 0 if params[:glider_initial_log][:instructor_number].empty?
    params[:glider_initial_log][:number_of_stall_recovery] = 0 if params[:glider_initial_log][:number_of_stall_recovery].empty?

    params.require(:glider_initial_log).permit(:date, :non_power_total_time, :non_power_total_number, :pic_winch_time, :pic_winch_number, :pic_aero_tow_time, :pic_aero_tow_number, :solo_winch_time, :solo_winch_number, :solo_aero_tow_time, :solo_aero_tow_number, :dual_winch_time, :dual_winch_number, :dual_aero_tow_time, :dual_aero_tow_number, :power_total_time, :power_total_number, :pic_power_time, :pic_power_number, :pic_power_off_time, :pic_power_off_number, :solo_power_time, :solo_power_number, :solo_power_off_time, :solo_power_off_number, :dual_power_time, :dual_power_number, :dual_power_off_time, :dual_power_off_number, :cross_country_time, :instructor_time, :instructor_number, :number_of_stall_recovery)
  end

  def correct_user
    @glider_initial_log = current_user.glider_initial_log
    redirect_to root_url if @glider_initial_log.nil?
  end
end
