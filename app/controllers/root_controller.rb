class RootController < ApplicationController
  PER = 12
  def top
  	#ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
  	if user_signed_in?
  	@favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
  	@join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    #--------------------------------------------------------------
    #招待件数
    @notification = UserGroup.where(user_id: current_user.id, entry: false).count
    end
    #公開している全てのレシピ
  	#ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	open_group = Group.where(restrict: false).ids
    @open_recipe = Recipe.where(group_id: open_group)
    #週間・月間のレシピ
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    now  = Time.new.tomorrow.at_beginning_of_day
    month = (now - 1.month)
    week = (now - 7.day).at_end_of_day
    @week_views = Recipe.where(group_id: open_group, created_at: week...now).order(views: "DESC").page(params[:week_peage]).per(PER)#.limit(12)
  	@month_views = Recipe.where(group_id: open_group, created_at: month...now).order(views: "DESC").page(params[:month_page]).per(PER)
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @recommended = Recipe.where(group_id: open_group, created_at: month...now).sample(6)
    # @recommended = @open_recipe.find(Keep.group(:recipe_id).order('count(recipe_id) desc').limit(12).pluck(:recipe_id))
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  end
end
