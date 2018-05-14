class HomeController < ApplicationController
  layout "public/application"
  def index
    @static_pages = Product.unlock.paginate page: params[:page], per_page: Settings.admin.number_items_per_page
    @products = Product.unlock
    @categories = Category.all
    @order_item = OrderDetail.new
    session[:total] = 0 unless session[:total]
  end
end
