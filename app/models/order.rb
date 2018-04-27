class Order < ApplicationRecord
  has_many :oder_details, dependent: :destroy
  belongs_to :user
end
