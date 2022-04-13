class LicensesController < ApplicationController
  def show
    binding.pry
    @user = User.find(params[:id])
    @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  def edit
  end

  def index
  end
end
