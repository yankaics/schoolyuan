class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!

  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "请先登录"
        redirect_to login_url
      end
    end
end
