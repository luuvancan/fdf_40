class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum sex: {female: 0, male: 1}
  enum role: {user: 0, admin: 1}

  default_scope ->{order(created_at: :desc)}
  before_save{email.downcase!}
end
