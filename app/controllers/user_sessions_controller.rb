class UserSessionsController < ApplicationController
  before_action :check_current_user, only: [:new, :create]

  skip_before_action :require_user, only: [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    reset_session
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    reset_session
    redirect_to login_path
  end

  private

  def check_current_user
    redirect_to root_path if current_user
  end

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end

