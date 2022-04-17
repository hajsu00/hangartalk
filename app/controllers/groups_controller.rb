class GroupsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_sideber_data, only: [:new, :show, :edit, :index]
  def new
    @group = Group.new
    @user = current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      redirect_to group_path(id: @group.id), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def index
    @groups = Group.all
    @groups_belonging_to = current_user.groups
    @user = current_user
  end

  def show
    @current_group = Group.find_by(id: params[:id])
    @user = current_user
  end

  def destroy
    @group.destroy
    flash[:success] = "グループを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :security, user_ids: [])
  end

  def correct_user
    @group = current_user.groups.find_by(id: params[:id])
    redirect_to root_url if @group.nil?
  end
end
