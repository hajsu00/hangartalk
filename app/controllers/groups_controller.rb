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
    if @group.save && @group.group_users.create!(user_id: current_user.id)
      redirect_to group_path(id: @group.id), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def index
    @user = @current_user
    @belonging_group = @user.groups
    @recommended_groups = Group.all - @belonging_group
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = "グループの更新に成功しました！"
      redirect_to groups_url
    else
      render 'groups/edit'
    end
  end

  def show
    @current_group = Group.find(params[:id])
    @group_members = @current_group.users
    @glider_group_flights = @current_group.glider_group_flights.order(takeoff_time: :asc).page(params[:page]).per(10)
    @user = current_user
  end

  def destroy
    @group.destroy
    flash[:success] = "グループを削除しました。"
    redirect_to groups_url
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :security, :group_cover, user_ids: [])
  end

  def correct_user
    @group = current_user.groups.find_by(id: params[:id])
    redirect_to root_url if @group.nil?
  end
end
