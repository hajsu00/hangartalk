class GliderInitialLogsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @glider_initial_log.destroy
    binding.pry
    current_user.reload_glider_initial_log
    flash[:success] = "過去のフライトログを削除しました。"
    binding.pry
    redirect_to request.referrer || root_url
  end

  private

  def correct_user
    @glider_initial_log = current_user.glider_initial_log
    redirect_to root_url if @glider_initial_log.nil?
  end
end
