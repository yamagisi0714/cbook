class Material < ApplicationRecord
	belongs_to :recipe

	include RankedModel
	ranks :material_num, class_name: 'Material'
end
