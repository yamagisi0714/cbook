class Material < ApplicationRecord
	belongs_to :recipe
	belongs_to :unit
end
