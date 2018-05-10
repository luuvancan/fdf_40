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

  def descendants
    subcategories.inject(subcategories) do |all, subcat|
      all + subcat.descendants
    end
  end

  def self_and_descendants
    [self] + descendants
  end

  def load_cat_parent_id
    Category.all.map(&:id).uniq - branch_ids
  end

  def load_cat_parent
    Category.where("id in (?)", load_cat_parent_id)
  end

  def branch_ids
    self_and_descendants.map(&:id).uniq
  end
end
