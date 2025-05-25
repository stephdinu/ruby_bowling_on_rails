class Game < ApplicationRecord
  has_one :player
  has_many :frames

  validates :player, presence: true

  after_create :create_default_frames

  private

  def create_default_frames
    10.times do |i|
      tries = (i == 9) ? 2 : 2
      frames.create(position: i+1, tries: tries)
    end
  end
end
