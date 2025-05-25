class Frame < ApplicationRecord
  has_many :pins, dependent: :destroy
  belongs_to :game

  after_create :create_default_pins

  private

  def initialize_pins
    10.times do
      pins.create(down: false)
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

  def extra_tries_available?
    position == 10 && (is_strike || is_spare)
  end

  def max_tries
    return 3 if extra_tries_available?
    2
  end
end
