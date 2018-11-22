class RecipesController < ApplicationController

  def index
  	@recipes = Recipe.all
  end

  def new
  	#ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    @join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
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
    #並び順の番号
    #--------------------------------------------------------------
    @steps = @recipe.steps
    @steps.each_with_index do |step,i|
      step.procedure_num = i+1
      step.save
    end
    #--------------------------------------------------------------
  	redirect_to recipe_path(@recipe)
  end

  def show
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    @join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	# 本人と公開グループに投稿したものは全てユーザーに表示させる
    @recipe = Recipe.find(params[:id])
    @step = @recipe.steps.order(procedure_num: "ASC")
    @group = Group.find_by(id: @recipe.group_id)
    if @group.restrict == true && !UserGroup.find_by(entry: true,  group_id: @group.id, user_id: current_user.id)
      redirect_to root_path
    end
  end

  def edit
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    @join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	# 本人のみ編集可能
  	@recipe = Recipe.find(params[:id])
    group = UserGroup.where(entry: true, user_id: current_user.id).pluck(:group_id)
    @ingroup = Group.where(id: group)
  end

  def update
  	@recipe = Recipe.find(params[:id])
  	@recipe.update(recipe_params)
    #並び順の番号
    #--------------------------------------------------------------
    @steps = @recipe.steps
    @steps.each_with_index do |step,i|
      step.procedure_num = i+1
      step.save
    end
    #--------------------------------------------------------------
  	redirect_to recipe_path(@recipe)
  end

  def destroy
  	recipe = Recipe.find(params[:id])
  	recipe.destroy
  	redirect_to recipes_path
  end

  def count
  	recipe = Recipe.find(params[:recipe_id])
  	recipe.views += 1
  	recipe.save
  	redirect_to recipe_path(recipe)
  end
  private
	  def recipe_params
	    params.require(:recipe).permit(:views, :title, :cook_image, :count, :category_id, :group_id, materials_attributes: [:id, :material_name, :quantity, :done, :_destroy], steps_attributes: [:id, :procedure_num, :procedure, :done, :step_image, :_destroy])
	  end
end
