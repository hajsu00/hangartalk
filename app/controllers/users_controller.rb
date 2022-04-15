class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:index, :following, :followers]
  before_action :authenticate_user!
  # before_action :correct_user,   only: [:edit, :update]
  # before_action :admin_user,     only: :destroy
  before_action :set_sideber_data, only: [:show, :edit, :index, :following, :followers]

  def index
    @user = User.find(params[:id])
    # @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
    render 'users/index'
  end

  def show
    users = User.includes([:licenses, following: :active_relationships, followers: :passive_relationships])
    @user = users.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).includes([:like_relationships, replying: :replying_relationships, replied: :replied_relationships, sharing: :sharing_relationships, shared: :shared_relationships, glider_flight: :glider_micropost_relationships]).page(params[:page]).per(10)
    # @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
    @licenses = @user.licenses
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     @user.send_activation_email
  #     flash[:info] = "入力されたメールアドレスに認証メールを送信しました。アカウントの有効化を行ってください。"
  #     redirect_to root_url
  #   else
  #     flash[:danger] = "ユーザー登録に失敗しました。入力内容を確認してください。"
  #     redirect_to new_user_path
  #   end
  # end

  def edit
    users = User.includes([following: :active_relationships, followers: :passive_relationships])
    @user = users.find(params[:id])
    # @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
  end

  # def update
  #   if @user.update(user_params)
  #     flash[:success] = "プロフィールを更新しました"
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end

  # def destroy
  #   User.find(params[:id]).destroy
  #   flash[:success] = "User deleted"
  #   redirect_to users_url
  # end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.order(created_at: :desc).includes([following: :active_relationships, followers: :passive_relationships]).page(params[:page]).per(10)
    # @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc).includes([following: :active_relationships, followers: :passive_relationships]).page(params[:page]).per(10)
    # @glider_flights = @user.glider_flights.order(created_at: :asc).order(log_number: :asc).page(params[:page]).per(10)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  # beforeアクション
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
