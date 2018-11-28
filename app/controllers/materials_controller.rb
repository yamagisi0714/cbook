class MaterialsController < ApplicationController
  def sort2
    material = Material.find(params[:material_id])
    material.update(material_params)
  end

  private
	  def material_params
      params.require(:material).permit(:recipe_id, :material_num_position, :quantity, :material_name)
	  end
end
