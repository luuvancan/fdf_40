class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  default_scope ->{order(created_at: :desc)}
  enum status: {paid: 1, unpaid: 0}
end
