class Game < ApplicationRecord
  belongs_to :player
  has_many :frames, dependent: :destroy

  after_create :initialize_frames

  private

  def initialize_frames
    10.times do |i|
      frames.create(position: i+1, tries: 0)
    end
  end
end
