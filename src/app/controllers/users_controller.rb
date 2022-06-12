class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :index, :following, :followers]
  before_action :set_sideber_data, only: [:show, :edit, :index, :following, :followers]

  def index
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).includes([:images_attachments,
                                                                      :like_relationships,
                                                                      :replying,
                                                                      :replied,
                                                                      :sharing,
                                                                      :shared,
                                                                      :glider_flight, { replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, glider_flight: :glider_micropost_relationships }]).page(params[:page]).per(10)
  end

  def edit
    @user = users.find(params[:id])
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.order(created_at: :desc).includes([following: :active_relationships, followers: :passive_relationships]).page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc).includes([following: :active_relationships, followers: :passive_relationships]).page(params[:page]).per(10)
    render 'show_follow'
  end

  # def show_reccomend
  #   @users = User.all
  #   @following = @user.following
  #   @reccomended_users = @users.map! { |user| filter_reccomended_users(user) }
  #   @reccomended_users.compact
  # end

  # def filter_reccomended_users(user)
  #   user if !@following.include(user)
  # end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  # beforeアクション

  def set_user_data
    users = User.includes([:licenses,
                           :microposts,
                           { following: :active_relationships,
                             followers: :passive_relationships }])
    @user = users.find(params[:id])
  end
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
