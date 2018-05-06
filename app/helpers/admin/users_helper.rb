module Admin
  module UsersHelper
    def load_role_form
      [[I18n.t("admin.users.index.admin"), "admin"],
       [I18n.t("admin.users.index.user"), "user"]]
    end
  end
end
