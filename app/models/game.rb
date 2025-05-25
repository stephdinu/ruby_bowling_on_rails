class Game < ApplicationRecord
  belongs_to :player
  has_many :frames, dependent: :destroy

  after_create :initialize_frames

  private

  def initialize_frames
    10.times do |i|
      tries = (i == 9) ? 2 : 2
      frames.create(position: i+1, tries: tries)
    end
  end
end
