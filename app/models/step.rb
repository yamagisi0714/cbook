class Step < ApplicationRecord
	belongs_to :recipe
	attachment :step_image

	include RankedModel
	ranks :procedure_num, class_name: 'Step'
end
