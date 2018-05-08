module Admin
  module OrdersHelper
    def load_status_form
      [[I18n.t("admin.orders.index.paid"), "paid"],
       [I18n.t("admin.orders.index.unpaid"), "unpaid"]]
    end
  end
end
