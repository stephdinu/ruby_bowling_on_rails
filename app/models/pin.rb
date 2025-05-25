class Pin < ApplicationRecord
	validates :down, presence: true
	attribute :down, default: -> { false }
	belongs_to :frame
end
