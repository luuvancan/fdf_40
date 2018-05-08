class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  scope :by_order_id, ->(order_id){where order_id: order_id}
end
