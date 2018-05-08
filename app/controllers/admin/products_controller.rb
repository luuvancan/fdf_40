module Admin
  class ProductsController < ApplicationController
    layout "admin/application"

    before_action :logged_in_user
    before_action :load_product, except: %i(index new create)
    before_action :load_categories, except: :index
    before_action :admin_user, only: %i(edit update destroy)

    def index
      @products = Product.all.paginate page: params[:page], per_page: Settings.admin.number_items_per_page
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new product_params
      if Product.by_name(@product.name).blank?
        save_product @product
      else
        @message = t "admin.products.new.exist_error"
        render :new
      end
    end

    def show
      render :edit
    end

    def edit; end

    def update
      product = Product.new product_params
      if Product.by_name(product.name).by_id_not_match(@product.id).blank?
        update_product @product
      else
        @message = t "admin.products.new.exist_error"
        @product.update product_params
        render :edit
      end
    end

    def destroy
      if @product.destroy
        flash[:success] = t "admin.products.new.success_delete_msg"
      else
        flash[:danger] = t "admin.products.new.danger_delete_msg"
      end
      redirect_to admin_products_url
    end

    private

    def product_params
      params.require(:product).permit :name, :price, :image, :description, :category_id
    end

    def load_categories
      @categories = Category.all
    end

    def load_product
      @product = Product.find_by id: params[:id]
      return if @product.present?
      flash[:danger] = t "admin.products.index.not_find_product"
      redirect_to admin_products_url
    end

    def save_product add_product
      if add_product.save
        flash[:success] = t "admin.products.new.success_add_msg"
        redirect_to admin_products_url
      else
        render :new
      end
    end

    def update_product update_pro
      if update_pro.update product_params
        flash[:success] = t "admin.products.edit.success_edit_msg"
        redirect_to admin_products_url
      else
        render :edit
      end
    end
  end
end
