module Public
  class OrderDetailsController < ApplicationController
    layout "public/application"

    def create
      session[:order_items] = [] if session[:order_items].blank?
      @order_detail = OrderDetail.new order_detail_params
      product = Product.find_by id: @order_detail.product_id
      check = 0
      session[:order_items].each do |row|
        next unless row[1] == product.id
        check = 1
        row[0] = row[0] + @order_detail.quantity
        break
      end
      session[:order_items] << [@order_detail.quantity, @order_detail.product_id] if check.zero?
      session[:total] += product.price * @order_detail.quantity
      respond_to do |format|
        format.html{redirect_to root_url}
        format.js
      end
    end

    def update
      @order_detail = OrderDetail.new order_detail_params
      product = Product.find_by id: @order_detail.product_id
      check = 0
      session[:order_items].each do |row|
        next unless row[1] == product.id
        check = 1
        session[:total] = session[:total] - (row[0] - @order_detail.quantity) * product.price
        row[0] = @order_detail.quantity
        break
      end
      redirect_to public_cart_path
    end

    def destroy
      product = Product.find_by id: params[:id]
      session[:order_items].each do |row|
        next unless row[1] == product.id
        session[:total] = session[:total] - row[0] * product.price
        session[:order_items].delete(row)
        break
      end
      redirect_to public_cart_path
    end

    private

    def order_detail_params
      params.require(:order_detail).permit(:quantity, :product_id)
    end
  end
end
