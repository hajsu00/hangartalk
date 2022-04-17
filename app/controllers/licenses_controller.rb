class LicensesController < ApplicationController
  before_action :set_pulldown_info, only: [:new, :edit]
  before_action :set_sideber_data, only: [:new, :show, :edit, :index]

  def new
    @license = License.new
    @user = User.find(params[:user_id])
  end

  def create
    @license = current_user.licenses.build(license_params)
    @reccurent_histories = @license.reccurent_histories.build(date: @license.date_of_issue, valid_for: 2)
    binding.pry
    if @license.save && @reccurent_histories.save
      flash[:success] = "ライセンスの登録に成功しました"
      redirect_to user_license_url
    else
      redirect_to new_user_license_url
    end
  end

  def show
    @user = User.find(params[:user_id])
    @license = @user.licenses.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @license = License.find(params[:id])
  end

  def update
    @license = License.find_by(id: params[:id])
    if @license.update(license_params)
      flash[:success] = "ライセンスの更新に成功しました"
      redirect_to user_license_url
    else
      redirect_to edit_user_license_url
    end
  end

  def index
    @user = User.find(params[:user_id])
    @licenses = @user.licenses.includes([:reccurent_histories])
  end

  private

  def license_params
    params.require(:license).permit(:code, :license_category_id, :aircraft_category_id, :date_of_issue)
  end

  def set_pulldown_info
    @license_categories = LicenseCategory.all
    @aircraft_categories = AircraftCategory.all
  end
end
