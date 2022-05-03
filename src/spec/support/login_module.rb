module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'メールアドレス *', with: user.email
    fill_in 'パスワード（半角英数字で６文字以上）*', with: 'password'
    click_button 'ログイン'
  end
end