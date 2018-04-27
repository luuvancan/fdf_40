class Product < ApplicationRecord
  belongs_to :category
  has_many :oder_details, dependent: :destroy
end
