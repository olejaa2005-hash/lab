class ApplicationController < ActionController::Base
  include Authentication
  helper_method :current_user, :logged_in?, :teacher?, :student?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def teacher?
    logged_in? && current_user.role == "teacher"
  end

  def student?
    logged_in? && current_user.role == "student"
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Будь ласка, увійдіть у систему."
    end
  end
end