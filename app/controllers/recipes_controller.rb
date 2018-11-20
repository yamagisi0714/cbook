class RecipesController < ApplicationController

  def index
  	@recipes = Recipe.all
  end

  def new
  	# 公開範囲の指定　投稿するグループの指定
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
    @steps = @recipe.steps
    @steps.each_with_index do |step,i|
      step.procedure_num = i+1
      step.save
    end
  	redirect_to recipe_path(@recipe)
  end

  def show
  	# 本人と公開グループに投稿したものは全てユーザーに表示させる
    @recipe = Recipe.find(params[:id])
    @group = Group.find_by(id: @recipe.group_id)
    if @group.restrict == true && !UserGroup.find_by(entry: true,  group_id: @group.id, user_id: current_user.id)
      redirect_to root_path
    end
  end

  def edit
  	# 本人のみ編集可能
  	@recipe = Recipe.find(params[:id])
  end

  def update
  	@recipe = Recipe.find(params[:id])
  	@recipe.update(recipe_params)
  	redirect_to recipe_path(@recipe)
  end

  def destroy
  	recipe = Recipe.find(params[:id])
  	recipe.destroy
  	redirect_to recipes_path
  end

  def count
  	views = Recipe.find(params[:id])
  	views.count += 1
  	views.save
  	redirect_to recipe_path(views)
  end
  private
	  def recipe_params
	    params.require(:recipe).permit(:views, :title, :cook_image, :count, :category_id, :group_id, materials_attributes: [:id, :material_name, :quantity, :done, :_destroy], steps_attributes: [:id, :procedure_num, :procedure, :done, :step_image, :_destroy])
	  end
end
