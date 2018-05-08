module Public
  class OrdersController < ApplicationController
    layout "public/application"

    before_action :logged_in_user

    def create
      order = Order.new user_id: current_user.id, date_order: Date.today, total_price: session[:total]
      order.save
      order = Order.where("user_id = ?", current_user.id).first
      session[:order_items].each do |row|
        product = Product.find_by id: row[1]
        order_detail = OrderDetail.new product_id: row[1], quantity: row[0], order_id: order.id, price: product.price
        order_detail.save
      end
      session[:total] = 0
      session[:order_items] = []
      order_details = OrderDetail.by_order_id order.id
      OrderMailer.result_order(current_user, order, order_details).deliver_now
      flash[:success] = t "public.orders.success"
      redirect_to public_cart_path
    end
  end
end
