class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password
  validates :email, presence: true,
    length: {maximum: Settings.admin.user.max_length_email},
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.admin.user.min_length_password},
    allow_nil: true
  validates :full_name, presence: true
  validates :phone, presence: true,
    numericality: true,
    length: {minimum: Settings.admin.user.phone_min_length, maximum: Settings.admin.user.phone_max_length}
  validates :address, presence: true

  enum sex: {female: 0, male: 1}
  enum role: {user: 0, admin: 1}

  default_scope ->{order(created_at: :desc)}
  before_save{email.downcase!}

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update remember_digest: nil
  end
end
