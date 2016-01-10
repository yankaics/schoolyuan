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
    @user = User.find(params[:id])
  end

  def edit
    # @user = User.find(params[:id]) # correct已定义
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 处理更新成功的情况
      flash[:success] = "个人信息更新成功"
      redirect_to @user
    else
      render 'edit'
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

  #条件查询好友
  def searchfriends
    sex=params[:result][:sex]
    from_height=params[:result][:from_height]
    to_height=params[:result][:to_height]
    from_age=params[:result][:from_age]
    to_age=params[:result][:to_age]
    married=params[:result][:married]

    married_info=false
    if married=="是"
      married_info=true

    end


    @friends =  sex=="" ? User.all : User.where("gender= ? ",sex)
    @friends = from_height=="" || to_height=="" ? @friends : @friends.where("height BETWEEN ? AND ? ", from_height, to_height)

    @friends = married=="" ? @friends : @friends.where("married_info = ?",married_info)

    @friends = from_age=="" || to_age=="" ? @friends : @friends.where("age BETWEEN ? AND ? ", from_age, to_age)


    respond_to do |format|
      format.js
    end

  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
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
