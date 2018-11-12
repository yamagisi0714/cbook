class Unit < ApplicationRecord
	has_many :materials, dependent: :destroy
end
