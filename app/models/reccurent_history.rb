class ReccurentHistory < ApplicationRecord
  belongs_to :license

  # def new
  #   @license_history = LicenseHistory.new
  #   @license = License.find(params[:id])
  #   # @license_categories = LicenseCategory.all
  #   # @aircraft_categories = AircraftCategory.all
  # end

  # def create
  #   @license = current_user.licenses.build(license_params)
  #   @reccurent_histories = @license.reccurent_histories.build(date: @license.date_of_issue, valid_for: 2)
  #   if @license.save && @reccurent_histories.save
  #     flash[:success] = "ライセンスの登録に成功しました"
  #     redirect_to user_license_url
  #   else
  #     redirect_to enw_user_license_url
  #     # @license_categories = LicenseCategory.all
  #     # @aircraft_categories = AircraftCategory.all
  #     # render 'licenses/new'
  #   end
  # end

  # def show
  #   users = User.includes([:licenses, following: :active_relationships, followers: :passive_relationships])
  #   @user = users.find(params[:user_id])
  #   @license = @user.licenses.find(params[:id])
  # end

  # def edit
  #   users = User.includes([:licenses, following: :active_relationships, followers: :passive_relationships])
  #   @user = users.find(params[:user_id])
  #   @license = License.find(params[:id])
  #   @license_categories = LicenseCategory.all
  #   @aircraft_categories = AircraftCategory.all
  # end

  # def update
  #   @license = License.find_by(id: params[:id])
  #   if @license.update(license_params)
  #     flash[:success] = "ライセンスの更新に成功しました"
  #     redirect_to user_license_url
  #   else
  #     redirect_to edit_user_license_url
  #     # @license_categories = LicenseCategory.all
  #     # @aircraft_categories = AircraftCategory.all
  #     # render 'licenses/edit'
  #   end
  # end

  # def index
  #   @user = User.find(params[:user_id])
  #   @licenses = @user.licenses.includes([:reccurent_histories])
  # end

  # private

  # def license_params
  #   params.require(:license).permit(:code, :license_category_id, :aircraft_category_id, :date_of_issue)
  # end
end
