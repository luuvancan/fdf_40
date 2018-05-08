module Admin
  class IndexController < ApplicationController
    layout "admin/application"

    before_action :load_order, except: :index
    before_action :load_order_details, except: %i(index destroy)

    def index
      @orders = Order.all.paginate page: params[:page], per_page: Settings.admin.number_items_per_page
    end

    def edit; end

    def show
      render :edit
    end

    def update
      if @order.update order_params
        flash[:success] = t "admin.orders.edit.success_edit_msg"
        redirect_to admin_orders_url
      else
        render :edit
      end
    end

    def destroy
      if @order.destroy
        flash[:success] = t "admin.orders.index.success_delete_msg"
      else
        flash[:danger] = t "admin.orders.index.danger_delete_msg"
      end
      redirect_to admin_orders_url
    end

    def user_order
      @orders = Order.by_user(current_user.id).paginate page: params[:page], per_page: Settings.admin.number_items_per_page
    end

    private

    def order_params
      params.require(:order).permit :status
    end

    def load_order
      @order = Order.find_by id: params[:id]
    end

    def load_order_details
      @order_details = OrderDetail.by_order_id params[:id]
      @orders = OrderDetail.all
    end
  end
end
