class AddDefaultToUsersRoles < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :roles, :integer, default: 0
  end
end
