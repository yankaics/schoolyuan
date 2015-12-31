class AccountActivationsController < ApplicationController
  def edit # 激活账号
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id]) # !user.activated?的作用是避免激活已经激活的用户
      user.activate
      log_in user
      flash[:success] = "账号激活成功"
      redirect_to user
    else
      flash[:danger] = "无效的激活链接"
      redirect_to root_url
    end
  end
end
