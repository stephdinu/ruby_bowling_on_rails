class Frame < ApplicationRecord
  has_many :pins

  after_create :create_default_pins

  attribute: :tries, default: -> { 2 }

  private

  def create_default_pins
    10.times do
      pins.create()
    end
  end
end
