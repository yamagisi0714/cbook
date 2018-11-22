class RootController < ApplicationController
  def top
  	#ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
  	if user_signed_in?
  	@favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
  	@join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    end
  	#ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	group = Group.where(restrict: false).ids
  	@views = Recipe.where(group_id: group).order(views: "ASC")
  end
end
