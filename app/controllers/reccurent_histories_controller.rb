class ReccurentHistoriesController < ApplicationController
  before_action :set_sideber_data, only: [:new, :show, :edit, :index]
  before_action :set_reccurent_history_data, only: [:new, :show, :edit, :index]
  def new
    @reccurent_history = ReccurentHistory.new
  end

  def create
  end

  def edit
    @reccurent_history = @license.reccurent_histories.find(params[:id])
  end

  def update
  end

  def show
    @reccurent_history = @license.reccurent_histories.find(params[:id])
  end

  def index
    @reccurent_histories = @license.reccurent_histories
  end

  private

  def set_reccurent_history_data
    @user = User.find(params[:user_id])
    @license = @user.licenses.find(params[:license_id])
  end
end
