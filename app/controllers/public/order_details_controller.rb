module Public
  class OrderDetailsController < ApplicationController
    layout "public/application"

    before_action :new_order_detail, :load_product, only: %i(create update)

    def create
      session[:order_items] = [] if session[:order_items].blank?
      check = 0
      session[:order_items].each do |row|
        next unless row[1] == @product.id
        check = 1
        row[0] = row[0] + @order_detail.quantity
        break
      end
      session[:order_items] << [@order_detail.quantity, @order_detail.product_id] if check.zero?
      session[:total_price] += @product.price * @order_detail.quantity
      respond_to do |format|
        format.html{redirect_to root_url}
        format.js
      end
    end

    def update
      check = 0
      session[:order_items].each do |row|
        next unless row[1] == @product.id
        check = 1
        session[:total_price] = session[:total_price] - (row[0] - @order_detail.quantity) * @product.price
        row[0] = @order_detail.quantity
        break
      end
      redirect_to public_cart_path
    end

    def destroy
      product = Product.find_by id: params[:id]
      session[:order_items].each do |row|
        next unless row[1] == product.id
        session[:total_price] = session[:total_price] - row[0] * product.price
        session[:order_items].delete(row)
        break
      end
      redirect_to public_cart_path
    end

    private

    def new_order_detail
      @order_detail = OrderDetail.new order_detail_params
      redirect_to root_url if @order_detail.nil?
    end

    def load_product
      @product = Product.find_by id: @order_detail.product_id
      redirect_to root_url if @order_detail.nil?
    end

    def order_detail_params
      params.require(:order_detail).permit(:quantity, :product_id)
    end
  end
end
