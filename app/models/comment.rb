class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :title, presence: true
  validates :content, presence: true
  validates :rating, presence: true,
    numericality: {less_than: 5, greater_than_or_equal_to: 0}
  scope :by_product, ->(id){where product_id: id}
  scope :by_product_sum_rating, ->(id){where(product_id: id).sum(:rating)}
end
