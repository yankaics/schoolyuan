class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 登入用户，然后重定向到用户的资料页面
      # 禁止未激活的用户登录
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # remember user
      # redirect_to user
        redirect_back_or user
      else
        message = "账号未被激活，请在登录前激活账号"
        message += "检查邮件，获得激活链接"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # 创建一个错误消息
      flash.now[:danger] = '邮箱或密码错误' #不完全正确
      render 'new'
    end
  end
  
  # 销毁会话（退出用户）
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
