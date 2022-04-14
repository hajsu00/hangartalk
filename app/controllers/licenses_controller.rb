class LicensesController < ApplicationController
  def new
    @license = License.new
    @user = User.find(params[:user_id])
    @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  def create
    @license = current_user.licenses.build(license_params)
    @reccurent_histories = @license.reccurent_histories.build(date: @license.date_of_issue, valid_for: 2)
    if @license.save && @reccurent_histories.save
      flash[:success] = "ライセンスの登録に成功しました"
      redirect_to glider_flights_url
    else
      render 'licenses/new'
    end
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
    @license = @user.licenses.find(params[:id])
    @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  def index
    @user = User.find(params[:user_id])
    @licenses = @user.licenses.includes([:reccurent_histories])
    # @glider_licenses = @user.licenses.where("aircraft_category_id = ?", 1).includes([:reccurent_histories])
    # @aeroplane_licenses = @user.licenses.where("aircraft_category_id = ?", 2).includes([:reccurent_histories])
    @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  private

  def license_params
    params.require(:license).permit(:code, :license_category_id, :aircraft_category_id, :date_of_issue)
  end
end
