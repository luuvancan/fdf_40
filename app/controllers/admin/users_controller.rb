module Admin
  class UsersController < ApplicationController
    layout "admin/application"

    before_action :logged_in_user
    before_action :load_user, except: %i(index new create search)
    before_action :admin_user, only: %i(update destroy)

    def index
      @users = User.all.paginate page: params[:page], per_page: Settings.admin.number_items_per_page
    end

    def new
      @user = User.new
    end

    def show
      render :edit
    end

    def create
      @user = User.new user_params
      if @user.save
        flash[:success] = t "admin.users.new.success_add_msg"
        redirect_to admin_users_url
      else
        render :new
      end
    end

    def destroy
      if @user.destroy
        flash[:success] = t "admin.users.new.success_delete_msg"
      else
        flash[:danger] = t "admin.users.new.danger_delete_msg"
      end
      redirect_to admin_users_url
    end

    def edit; end

    def update
      if @user.update user_params
        flash[:success] = t "admin.users.edit.success_edit_msg"
        redirect_to admin_user_url(@user)
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit :full_name, :email, :password, :password_confirmation, :phone, :address, :sex, :role
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user.present?
      flash[:danger] = t "admin.users.index.not_find_user"
      redirect_to admin_users_url
    end
  end
end
