class Settings::AccountsController < Settings::ApplicationController
  before_action :current_password_required, only: [:update]
  before_action :logged_in_user, only:[:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only:[:edit, :update]
  before_action :admin_user, only: :destroy


  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:username, :email, :locale)
      flash[:success] = I18n.t('settings.accounts.flashes.successfully_updated')
      redirect_to settings_account_path
    else
      render :show
    end
  end
end
