class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :account, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :user_image

  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :keeps, dependent: :destroy
  has_many :favorites, dependent: :destroy
# 検索
  def self.search(search)
    if search
      User.where(['account LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
end
