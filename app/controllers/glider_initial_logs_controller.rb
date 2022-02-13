class GliderInitialLogsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
  end

  def create
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
    params.require(:glider_initial_log).permit(:non_power_total_time, :non_power_total_number, :pic_winch_time, :pic_winch_number, :pic_aero_tow_time, :pic_aero_tow_number, :solo_winch_time, :solo_winch_number, :solo_aero_tow_time, :solo_aero_tow_number, :dual_winch_time, :dual_winch_number, :dual_aero_tow_time, :dual_aero_tow_number, :power_total_time, :power_total_number, :pic_power_time, :pic_power_number, :pic_power_off_time, :pic_power_off_number, :solo_power_time, :solo_power_number, :solo_power_off_time, :solo_power_off_number, :dual_power_time, :dual_power_number, :dual_power_off_time, :dual_power_off_number, :cross_country_time, :instructor_time, :instructor_number, :number_of_stall_recovery)
  end

  def correct_user
    @glider_initial_log = current_user.glider_initial_log
    redirect_to root_url if @glider_initial_log.nil?
  end
end
