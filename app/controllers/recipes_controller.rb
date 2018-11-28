class RecipesController < ApplicationController

  def new
  	#ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    if current_user.user_groups.where(entry: true).count == 0
      redirect_to user_path(current_user), notice: "グループを作成もしくは参加しないとレシピは投稿できないです。"
    end
    @recipe = Recipe.new
    @material = @recipe.materials.build
    @step = @recipe.steps.build
    group = UserGroup.where(entry: true, user_id: current_user.id).pluck(:group_id)
    @ingroup = Group.where(id: group)
  end

  def create
  	@recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
  	@recipe.save
  	redirect_to recipe_path(@recipe)
  end

  def show
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	# 本人と公開グループに投稿したものは全てユーザーに表示させる
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @recipe = Recipe.find(params[:id])
    open_group = Group.where(restrict: false).ids
    @relations = Recipe.where(group_id: open_group, category_id: @recipe.category_id).sample(4)
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @steps = @recipe.steps.rank(:procedure_num)
    @materials = @recipe.materials.rank(:material_num)
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @group = Group.find_by(id: @recipe.group_id)
    if @group.restrict == true && !UserGroup.find_by(entry: true,  group_id: @group.id, user_id: current_user.id)
      redirect_to root_path
    end
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  end

  def edit
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	# 本人のみ編集可能
  	@recipe = Recipe.find(params[:id])
    unless @recipe.user_id == current_user.id
      redirect_to root_path
    end
    group = UserGroup.where(entry: true, user_id: current_user.id).pluck(:group_id)
    @ingroup = Group.where(id: group)
  end

  def update
  	@recipe = Recipe.find(params[:id])
  	@recipe.update(recipe_params)
  	redirect_to recipe_path(@recipe)
  end

  def destroy
  	recipe = Recipe.find(params[:id])
  	recipe.destroy
  	redirect_to user_path(current_user.id), notice: "削除しました"
  end

  def count
  	recipe = Recipe.find(params[:recipe_id])
  	recipe.views += 1
  	recipe.save
  	redirect_to recipe_path(recipe)
  end

  private
	  def recipe_params
	    params.require(:recipe).permit(:views, :title, :comment, :cook_image, :count, :category_id, :group_id, materials_attributes: [:id, :material_name, :material_num, :quantity, :done, :_destroy], steps_attributes: [:id, :procedure_num, :procedure, :done, :step_image, :_destroy])
    end
end
