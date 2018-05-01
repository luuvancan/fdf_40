module Admin
  class CategoriesController < ApplicationController
    layout "admin/application"

    def index; end

    def new
      @category = Category.new
    end

    def create; end

    def edit; end

    def destroy; end
  end
end
