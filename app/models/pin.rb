class Pin < ApplicationRecord
	validates :down, presence: true
	attribute :down, default: -> { false }
end
