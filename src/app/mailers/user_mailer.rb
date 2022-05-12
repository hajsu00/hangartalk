class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウントの有効化 | Hangar Talk"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Hangar Talk |  パスワード再設定のご案内"
  end
end
