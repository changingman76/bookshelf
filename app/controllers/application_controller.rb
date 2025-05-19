class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def logged_in?
    session[:user_id].present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'Bitte melden Sie sich an.'
    end
  end
end
