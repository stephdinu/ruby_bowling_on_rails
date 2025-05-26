class Frame < ApplicationRecord
  has_many :pins, dependent: :destroy
  belongs_to :game

  after_create :initialize_pins

  def is_strike
    tries == 1 && count_knocked_down_pins == 10
  end

  def is_spare
    tries == 2 && count_knocked_down_pins == 10
  end

  def is_complete
    position < 10 ? is_strike || tries == 2 : is_tenth_frame_complete
  end

  def count_knocked_down_pins
    pins.where(down: true).count
  end

  def roll(knocked_down_pins = nil)
    raise "Frame already has 2 tries!" if tries >= 2 && position < 10
    raise "Frame is complete!" if is_complete

    remaining = remaining_pins

    knocked_down_pins ||= rand(0..remaining.count)

    pins_to_knock_down = remaining_pins.limit(knocked_down_pins)
    pins_to_knock_down.update_all(down: true)
    
    increment!(:tries)
  end

  private

  def initialize_pins
    10.times do
      pins.create(down: false)
    end
  end

  def remaining_pins
    pins.where(down: false)
  end

  def extra_tries_available?
    position == 10 && (is_strike || is_spare)
  end

  def max_tries
    return 3 if extra_tries_available?
    2
  end

  def is_tenth_frame_complete
    return false if tries < 2
    return true if tries == 3
    tries == 2 && count_knocked_down_pins < 10
  end
end
