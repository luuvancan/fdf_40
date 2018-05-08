module Public
  class StaticPagesController < ApplicationController
    layout "public/application"
    def home
      @static_pages = Product.all.paginate page: params[:page], per_page: Settings.admin.number_items_per_page
      @products = Product.all
      @categories = Category.all
      @order_item = OrderDetail.new
      session[:total] = 0 unless session[:total]
    end
  end
end
