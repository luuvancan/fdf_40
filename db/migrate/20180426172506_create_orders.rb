class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime :date_order
      t.integer :status
      t.float :total_price

      t.timestamps
    end
  end
end
