class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Authentication::SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "authentication.sessions.message_not_login"
    redirect_to authentication_login_url
  end

  def admin_user
    return if admin_user?
    flash[:danger] = t "admin.users.index.not_admin"
    redirect_to admin_users_url
  end
end
