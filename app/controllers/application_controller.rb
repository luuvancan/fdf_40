class ApplicationController < ActionController::Base
  include Authentication::SessionsHelper
  helper_method :load_product

  def load_product product_id
    Product.find_by id: product_id
  end

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
