class SessionsController < ApplicationController
  def new
  end

  def create
    msg = nil
    if !captcha_valid? params[:captcha]
      msg = add_msg(msg, '验证码错误')
    end
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      if user.authenticate(params[:session][:password])
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
        msg = add_msg(msg, '密码错误')
      end
    else
      # 创建一个错误消息
      msg = add_msg(msg, '邮箱错误')
    end
    if msg
      flash.now[:danger] = msg
      render 'new'
    end

  end

  def add_msg(old_msg, add_msg)
    if old_msg
      return "#{old_msg}|#{add_msg}"
    end
    return add_msg
  end
  # 销毁会话（退出用户）
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
