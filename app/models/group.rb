class Group < ApplicationRecord
	has_many :user_groups, dependent: :destroy
	has_many :recipes, dependent: :destroy
	has_many :users, through: :user_groups, dependent: :destroy
	has_many :favorites, dependent: :destroy
	attachment :group_image

	validates :group_name, presence: true
	validates :group_name,    length: { maximum: 15 }
	validates :group_name, uniqueness: true

    def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
    end

    def self.search(search) #self.でクラスメソッドとしている
	    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
	    	Group.where(['group_name LIKE ?', "%#{search}%"])
	    else
	    	Group.all
		end
  	end
end
