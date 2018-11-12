class Step < ApplicationRecord
	belongs_to :recipe
	attachment :step_image
end
