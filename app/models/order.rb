class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  scope :by_user, ->(user_id){where user_id: user_id}
  default_scope ->{order(created_at: :desc)}
  enum status: {paid: 1, unpaid: 0}
end
