class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    respond_to do |format|
      if @order.save
        session[:order_id] = @order.id
        format.html { redirect_to root_url, notice: 'Product was successfully created.' }
        format.js
      end
    end

  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    order_items = @order.order_items
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
