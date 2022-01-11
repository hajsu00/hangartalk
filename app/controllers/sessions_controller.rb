class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = 'ログインに成功しました！'
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'ログインに失敗しました。入力内容を確認してください。'
      redirect_to new_user_path
    end
  end
  def destroy
  end
end
