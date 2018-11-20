class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
      User.where(['email LIKE ?', "%#{search}%"])
    end
  end

 #  after_create: create_group
 #  private
 # #  def create_group
 # #  	@new_group = Group.new
 # #  end
 # #  def create
 # #  	@new_group = Group.new(group_params, lock: 'true')
 # #    @new_group.save
 # #    @user_group = UserGroup.new(user_id: current_user.id, group_id: @new_group.id, entry: 'true', owner: 'true')
 # #    @user_group.save
 # #  end
 # #  def group_params
	# # params.require(:group).permit(:group_name, :group_image)
 # #  end
 # 	def create_group
 # 		@group = Group.create
 # 		current_user.user_groups.create(group_id: @group.id)

 # 	end
end
