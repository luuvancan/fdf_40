class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  before_save :update_subtotal
  def subtotal
    order_items.collect{|oi| oi.valid? ? (oi.quantity.to_i * oi.unit_price.to_i) : 0}.sum
  end

  private

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
