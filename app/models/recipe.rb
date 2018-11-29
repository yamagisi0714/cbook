class Recipe < ApplicationRecord
	has_many :keeps, dependent: :destroy
	has_many :steps, inverse_of: :recipe
	has_many :materials, inverse_of: :recipe

	belongs_to :user
	belongs_to :group
	belongs_to :category

	attachment :cook_image

	accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true

	def kept_by?(user)
          keeps.where(user_id: user.id).exists?
    end

    def self.search(search) #self.でクラスメソッドとしている
	    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
	      	Recipe.where(['name LIKE ?', "%#{search}%"])
	    else
			Recipe.all
		end
  	end
end
