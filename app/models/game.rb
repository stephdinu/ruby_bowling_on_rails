class Game < ApplicationRecord
  has_one :player
  has_many :frames

  after_create :create_default_frames

  private

  def create_default_frames
    10.times do
      frames.create()
    end
  end
end
