module Admin
  class CommentsController < ApplicationController
    layout "admin/application"
    before_action :admin_user, only: :destroy

    def index
      @comments = Comment.all.paginate page: params[:page], per_page: Settings.admin.number_items_per_page
    end

    def destroy
      @comment = Comment.find_by params[:id]
      if @comment.blank?
        flash[:danger] = "Not exist comment"
      else
        @comment.destroy
        flash[:success] = "Delete comment success"
      end
      redirect_to admin_comments_path
    end
  end
end
