require 'rails_helper'

RSpec.describe GameScoreboardService, type: :service do
  let(:player) { Player.create!(name: "Test Player") }
  let(:game) { player.games.create! }

  def knock_down_all_pins(frame, tries)
    standing_pins = frame.pins.where(down: false).limit(tries)
    standing_pins.update_all(down: true)
    frame.increment!(:tries)
  end

  it "calculates a perfect game score as 300" do
    game.frames.each_with_index do |frame, index|
      frame.pins.update_all(down: true)
      frame.update!(tries: 1)
      frame.increment!(:tries) if index == 9 # 10th frame gets extra tries
    end

    service = GameScoreboardService.new(game)
    expect(service.total_score).to eq(300)
  end

  it "calculates open frames correctly" do
    game.frames.each do |frame|
      knock_down_all_pins(frame, 4)
      knock_down_all_pins(frame, 3)
    end

    service = GameScoreboardService.new(game)
    expect(service.total_score).to eq(70)
  end

  it "handles spare scoring with 1 bonus" do
    frame1 = game.frames[0]
    knock_down_all_pins(frame1, 5)
    knock_down_all_pins(frame1, 5)

    frame2 = game.frames[1]
    knock_down_all_pins(frame2, 3)
    knock_down_all_pins(frame2, 2)

    service = GameScoreboardService.new(game)
    expect(service.total_score).to eq(10 + 3 + 5) # 18
  end

  it "handles strike scoring with 2 bonuses" do
    frame1 = game.frames[0]
    knock_down_all_pins(frame1, 10)
    frame1.update!(tries: 1)

    frame2 = game.frames[1]
    knock_down_all_pins(frame2, 3)
    knock_down_all_pins(frame2, 4)

    service = GameScoreboardService.new(game)
    expect(service.total_score).to eq(10 + 3 + 4 + 7)
  end
end
