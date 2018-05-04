class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :subcategories, class_name: Category.name,
                           foreign_key: :parent,
                           dependent: :destroy,
                           inverse_of: false

  validates :name, presence: true

  scope :by_parent_id_not_match_id, ->(id){where("parent <> :id or parent IS NULL", id: id)}
  scope :by_name, ->(name){where name: name}
  scope :by_id_not_match, ->(id){where.not id: id}
end
