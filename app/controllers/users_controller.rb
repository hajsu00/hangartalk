class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録に成功しました！"
      redirect_to @user
    else
      flash[:danger] = "ユーザー登録に失敗しました。入力内容を確認してください。"
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
