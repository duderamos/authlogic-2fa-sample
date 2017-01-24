class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user_session, :current_user

  before_action :require_user
  before_action :require_two_factor

  private

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def require_user
    redirect_to login_path unless current_user
  end

  def require_two_factor
    redirect_to confirm_url if current_user && !two_factor_confirmed?
  end

  def two_factor_confirmed?
    current_user.two_factor_confirmed_at.present? && session[:two_factor_confirmed_at] == current_user.two_factor_confirmed_at.to_i
  end
end
