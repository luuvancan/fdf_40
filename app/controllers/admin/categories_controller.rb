module Admin
  class CategoriesController < ApplicationController
    layout "admin/application"
    include CategoriesHelper

    before_action :logged_in_user
    before_action :load_category, except: %i(index new create)
    before_action :load_categories, only: %i(index)
    before_action :load_category_parent_cat_add, only: %i(new create)
    before_action :load_categories_by_not_match_id_and_parent_id, only: %i(edit update show)
    before_action :admin_user, only: %i(edit update destroy)

    def index; end

    def new
      @category = Category.new
    end

    def show
      render :edit
    end

    def create
      @category = Category.new category_params
      if Category.by_name(@category.name).blank?
        save_cat @category
      else
        @message = t "admin.categories.new.exist_error"
        render :new
      end
    end

    def edit; end

    def update
      category = Category.new category_params
      if Category.by_name(category.name).by_id_not_match(@category.id).blank?
        update_cat @category
      else
        flash[:danger] = t "admin.categories.new.exist_error"
        redirect_to admin_category_path
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t "admin.categories.new.success_delete_msg"
      else
        flash[:danger] = t "admin.categories.new.danger_delete_msg"
      end
      redirect_to admin_categories_url
    end

    private

    def category_params
      params.require(:category).permit :name, :parent
    end

    def load_categories_by_not_match_id_and_parent_id
      @categories = Category.by_id_not_match(@category.id).by_parent_id_not_match_id(@category.id)
      @categories = load_categories_add_no_parent @categories
    end

    def load_category
      @category = Category.find_by id: params[:id]
      return if @category.present?
      flash[:danger] = t "admin.categories.index.not_find_cat"
      redirect_to admin_categories_url
    end

    def load_categories
      @categories = Category.all
    end

    def save_cat add_category
      if add_category.save
        flash[:success] = t "admin.categories.new.success_add_msg"
        redirect_to admin_categories_url
      else
        render :new
      end
    end

    def update_cat update_category
      if update_category.update category_params
        flash[:success] = t "admin.categories.edit.success_edit_msg"
        redirect_to admin_categories_url
      else
        render :edit
      end
    end

    def load_category_parent_cat_add
      @categories = Category.all
      @categories = load_categories_add_no_parent @categories
    end
  end
end
