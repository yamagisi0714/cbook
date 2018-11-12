class Group < ApplicationRecord
	has_many :user_groups, dependent: :destroy
	has_many :recipes, dependent: :destroy
	has_many :users, through: :user_groups, dependent: :destroy
	attachment :group_image
end
