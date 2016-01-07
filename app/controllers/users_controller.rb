class UsersController < ApplicationController

  before_action :logged_in_user, only:[:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only:[:edit, :update]
  before_action :admin_user, only: :destroy

  def index 
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "邮件已发送至您的邮箱，请查收邮件以便激活您的账号"
      redirect_to root_url
=begin
      log_in @user
      flash[:success] = "欢迎来到校缘！让我们缘起校园"
      redirect_to @user
=end
    else
      render 'new'
    end
  end

  def settings
    @user = User.find_by_id(params[:id])
  end

  def update_settings
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(basic_params)
      flash[:success] = "基本信息更新成功"
    end
    if @user.update_attributes(accounts_params)
      flash[:success] = "账户信息更新成功"
    end
    if @user.update_attributes(loved_params)
      flash[:success] = "恋爱信息更新成功"
    end
    if @user.update_attributes(biography_params)
      flash[:success] = "背景信息更新成功"
    end
end

  def edit
    # @user = User.find(params[:id]) # correct已定义
  
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(basic_params)
      flash[:success] = "基本信息更新成功"
    elsif @user.update_attributes(accounts_params)
      flash[:success] = "账户信息更新成功"
    elsif @user.update_attributes(loved_params)
      flash[:success] = "恋爱信息更新成功"
    elsif @user.update_attributes(biography_params)
      flash[:success] = "背景信息更新成功"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "成功删除此用户"
    redirect_to users_url
  end

  def following
    @title = "关注"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private


    def accounts_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def basic_params
     params.require(:user).permit(:gender, :age, :height, :hometown, :constellation)
    end

    def loved_params
     params.require(:user).permit(:in_love_info, :married_info, :expected_lover)
    end

    def biography_params
     params.require(:user).permit(:edu_finished, :final_edu_school, :school_now, :school_now_loc)
    end


    # 事前过滤器
    
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "请先登录再访问."
        redirect_to login_url
      end
    end

    # 确保是正确的用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 确保是管理员
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
