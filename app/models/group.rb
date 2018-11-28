class Group < ApplicationRecord
	has_many :user_groups, dependent: :destroy
	has_many :recipes, dependent: :destroy
	has_many :users, through: :user_groups, dependent: :destroy
	has_many :favorites, dependent: :destroy
	attachment :group_image

    def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
    end
end
