class ReccurentHistoriesController < ApplicationController
  before_action :set_sideber_data, only: [:new, :show, :edit, :index]
  before_action :set_reccurent_history_data, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  before_action :authenticate_user!, only: [:edit, :destroy]

  def new
    @reccurent_history = ReccurentHistory.new
  end

  def create
    @reccurent_history = @license.reccurent_histories.build(reccurent_history_params)
    if @reccurent_history.save
      flash[:success] = "特定操縦技能審査合格履歴の作成に成功しました！"
      redirect_to user_license_reccurent_histories_url
    else
      redirect_to edit_user_license_reccurent_history_url
    end
  end

  def edit
    @reccurent_history = @license.reccurent_histories.find(params[:id])
  end

  def update
    @reccurent_history = @license.reccurent_histories.find(params[:id])
    if @reccurent_history.update(reccurent_history_params)
      flash[:success] = "特定操縦技能審査合格履歴の更新に成功しました！"
      redirect_to user_license_reccurent_histories_url
    else
      redirect_to edit_user_license_reccurent_history_url
    end
  end

  def show
    @reccurent_history = @license.reccurent_histories.find(params[:id])
    @reccurent_histories = @license.reccurent_histories
  end

  def index
    @reccurent_histories = @license.reccurent_histories
  end

  def destroy
    @license.reccurent_histories.find(params[:id]).destroy
    flash[:success] = "特定操縦技能審査合格の履歴を削除しました。"
    redirect_to edit_user_license_reccurent_history_url
  end

  private

  def reccurent_history_params
    params.require(:reccurent_history).permit(:date, :valid_for)
  end

  def set_reccurent_history_data
    @user = User.find(params[:user_id])
    @license = @user.licenses.find(params[:license_id])
  end
end
