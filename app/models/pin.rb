class Pin < ApplicationRecord
	belongs_to :frame
	attribute :down, default: false
	validates :down, inclusion: { in: [true, false] }
end
