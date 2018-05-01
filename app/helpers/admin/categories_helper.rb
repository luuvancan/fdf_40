module Admin
  module CategoriesHelper
    def load_categories_add_no_parent categories
      (categories.to_a << Category.new(name: I18n.t("admin.categories.no_parent"))).reverse
    end

    def display_categories_parent_form
      @categories.collect{|u| [u.name, u.id]}
    end
  end
end
