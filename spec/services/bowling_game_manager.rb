require 'rails_helper'

RSpec.describe BowlingGameManager, type: :service do
  let(:player) { Player.create!(name: "Test Player") }
  let(:game) { player.games.create! }
  let(:manager) { BowlingGameManager.new(game) }

  before do
    game.frames.each(&:setup_pins)
  end

  it "knocks down pins and increments tries in the current frame" do
    frame = game.frames.find_by(number: 1)
    expect(frame.tries).to eq(0)
    expect(frame.count_knocked_down_pins).to eq(0)

    manager.roll(4)

    frame.reload
    expect(frame.tries).to eq(1)
    expect(frame.count_knocked_down_pins).to eq(4)
  end

  it "advances to the next frame after two tries" do
    frame = game.frames.find_by(number: 1)
    manager.roll(3)
    manager.roll(6)

    frame.reload
    expect(frame.is_complete).to be true

    next_frame = game.frames.find_by(number: 2)
    expect(next_frame.tries).to eq(0)
  end

  it "handles a strike and moves to the next frame immediately" do
    frame = game.frames.find_by(number: 1)
    manager.roll(10)

    frame.reload
    expect(frame.tries).to eq(1)
    expect(frame.is_strike).to be true
    expect(frame.is_complete).to be true

    next_frame = game.frames.find_by(number: 2)
    expect(next_frame.tries).to eq(0)
  end

  it "raises an error when rolling after the game is complete" do
    game.frames.each do |frame|
      frame.pins.update_all(down: true)
      frame.update!(tries: 2)
    end

    expect { manager.roll(3) }.to raise_error("Game is complete!")
  end

  it "allows an extra roll in the 10th frame if a strike is scored" do
    frame_10 = game.frames.find_by(number: 10)
    frame_10.pins.update_all(down: true)
    frame_10.update!(tries: 1)

    manager.roll(0) # triggers the bonus logic

    frame_10.reload
    expect(frame_10.tries).to eq(2) # 1 original try + 1 bonus
  end
end
