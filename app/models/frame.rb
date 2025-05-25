class Frame < ApplicationRecord
  has_many :pins
  belongs_to :game

  after_create :create_default_pins

  attribute: :tries, default: -> { 2 }

  private

  def create_default_pins
    10.times do
      pins.create()
    end
  end

  def count_knocked_down_pins
    pins.where(down: true).count
  end

  def is_strike
    tries == 1 && count_knocked_down_pins == 10
  end

  def is_spare
    tries == 2 && count_knocked_down_pins == 10
  end
end
