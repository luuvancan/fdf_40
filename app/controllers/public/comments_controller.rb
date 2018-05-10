module Public
  class CommentsController < ApplicationController
    layout "public/application"

    def create
      comment = Comment.new comment_params
      product = Product.find_by id: comment.product_id
      if comment.save
        flash[:suceess] = "Add success"
      else
        flash[:danger] = "Add fail"
      end
      redirect_to public_product_path(product)
    end

    private

    def comment_params
      params.require(:comment).permit :rating, :title, :content, :product_id, :user_id
    end
  end
end
