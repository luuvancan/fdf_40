module Public
  class ProductsController < ApplicationController
    layout "public/application"

    def show
      @product = Product.find(params[:id])
      @comment = Comment.new
      @order_item = OrderDetail.new
      @comments = Comment.by_product(@product.id)
      @avg_rating = Comment.by_product_sum_rating(@product.id) / @comments.count if @comments.present?
    end

    def index
      @products = Product.by_category_id(1).paginate page: params[:page], per_page: Settings.admin.number_items_per_page
      @order_item = OrderDetail.new
      @category = Category.find_by id: 1
    end
  end
end
