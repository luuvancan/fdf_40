class Product < ApplicationRecord
  belongs_to :category
  has_many :oder_detail, dependent: :destroy

  mount_uploader :image, ImageUploader
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
    numericality: {less_than: Settings.admin.product.price_max,
                   greater_than_or_equal_to: Settings.admin.product.price_min}

  scope :by_name, ->(name){where name: name}
  scope :by_id_not_match, ->(id){where.not id: id}
  default_scope ->{order(created_at: :desc)}

  private

  def image_size
    errors.add(:image, Settings.admin.product.picture_error) if
    image.size > Settings.admin.product.size_image_upload.megabytes
  end
end
