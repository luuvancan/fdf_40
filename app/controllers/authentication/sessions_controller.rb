module Authentication
  class SessionsController < ApplicationController
    layout "authentication/application"

    def new; end

    def create
      user = User.find_by email: params[:session][:email].downcase
      if user && password_authenticate?(user)
        log_in user
        params[:session][:remember_me] == Settings.authentication.session.remember ? remember(user) : forget(user)
        redirect_to public_root_url
      else
        @message = t "authentication.sessions.new.error_messages"
        render :new
      end
    end

    def destroy
      log_out if logged_in?
      redirect_to authentication_login_path
    end
  end
end
