class KeepsController < ApplicationController
	def create
	    recipe = Recipe.find(params[:recipe_id])
	    keep = current_user.keeps.new(recipe_id: recipe.id)
	    keep.save
	    redirect_to recipe_path(recipe)
	end
	def destroy
	    recipe = Recipe.find(params[:recipe_id])
	    keep = current_user.keeps.find_by(recipe_id: recipe.id)
	    keep.destroy
	    redirect_to recipe_path(recipe)
	end
end
