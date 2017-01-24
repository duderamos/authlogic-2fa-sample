class UserSessionsController < ApplicationController
  before_action :check_current_user, only: [:new, :create]

  skip_before_action :require_user, only: [:new, :create]
  skip_before_action :require_two_factor

  def new
    @user_session = UserSession.new
  end

  def create
    reset_session
    @user_session = UserSession.new(user_session_params)

    if @user_session.save
      redirect_to two_factor_confirmed? ? root_path : confirm_url
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    reset_session
    redirect_to login_path
  end

  def confirm
  end

  def validate
    two_factor_secret = current_user.two_factor_secret
    validation_code   = params[:user_session][:validation_code]

    if validate_code(validation_code, two_factor_secret)
      session[:two_factor_confirmed_at] = current_user.confirm_two_factor!
      redirect_to root_path
    else
      render :confirm
    end
  end

  private

  def check_current_user
    redirect_to root_path if current_user
  end

  def validate_code(validation_code, two_factor_secret)
    ROTP::TOTP.new(two_factor_secret).verify_with_drift(validation_code, 60)
  end

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end

