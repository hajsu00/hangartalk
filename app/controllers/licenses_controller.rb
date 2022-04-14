class LicensesController < ApplicationController
  def new
  end

  def create
  end

  def show
    users = User.includes([:licenses, following: :active_relationships, followers: :passive_relationships])
    @user = users.find(params[:user_id])
    @license = @user.licenses.find(params[:id])
    @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  def edit
    users = User.includes([:licenses, following: :active_relationships, followers: :passive_relationships])
    @user = users.find(params[:user_id])
    @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  def index
  end
end
