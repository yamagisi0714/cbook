class RecipesController < ApplicationController

  def index
  	@recipe = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @material = @recipe.materials.build
    @step = @recipe.steps.build
  end

  def create
  	@recipe = Recipe.new(recipe_params)
  	@recipe.save
  	procedure = Step.new(procedure_num: procedure.id)
  	procedure.save
  	redirect_to recipe_path(@recipe)
  end

  def show
  	# 本人と公開グループに投稿したものは全てユーザーに表示させる
  	@recipe = Recipe.find(params[:id])
  end

  def edit
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
  private
	  def recipe_params
	    params.require(:recipe).permit(:title, :cook_image, materials_attributes: [:id, :material_name, :quantity, :done, :_destroy], steps_attributes: [:id, :procedure_num, :procedure, :details, :done, :_destroy])
	  end
end
