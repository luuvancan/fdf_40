module Authentication
  class UsersController < ApplicationController
    layout "authentication/application"

    def new
      @user = User.new
    end

    def create
      @user = User.new user_params
      if @user.save
        log_in @user
        redirect_to admin_user_url(@user)
      else
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit :full_name, :email, :password, :password_confirmation, :phone, :address, :sex
    end
  end
end
