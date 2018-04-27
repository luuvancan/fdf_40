class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
