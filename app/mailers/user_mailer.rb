class UserMailer < ApplicationMailer
  default from: "noreply@example.com"

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "账号激活"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "重设密码"
  end
end
