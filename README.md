
# Ruby Bowling on Rails

This is a Ruby on Rails API-only application which simulates a simple ten-pin bowling game.# Ruby Bowling on Rails

This is a Ruby on Rails API-only application that simulates a ten-pin bowling game. A `Player` can play a `Game` that consists of ten `Frames`, each containing `Pins` with logic for scoring strikes, spares, and open frames — including special rules for the 10th frame.

---

## Models Overview

### Player
- `name`: string
- `score`: integer (default: 0)
- Associations:
  - `has_many :games`

### Game
- Belongs to a `Player`
- Has `10 Frames` generated upon creation
- Game logic calculates score based on the standard bowling rules

### Frame
- Belongs to a `Game`
- Has `10 Pins` generated upon creation
- Tracks number of tries per frame
- Handles strike, spare, and open frame logic

### Pin
- Belongs to a `Frame`
- `down`: boolean (default: false)

---

## Features

- Support for full ten-frame games
- Proper handling of strikes, spares, and bonus rolls
- Auto-generation of frames and pins
- Accurate scoring based on future rolls
- RSpec test suite with edge case coverage

---

## Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/stephdinu/ruby_bowling_on_rails.git
cd ruby_bowling_on_rails
```
### Install Dependencies
 ```bash
 bundle install
```
### Setup Database
```bash
 rails db:create
 rails db:migrate
```
### Run Tests (RSpec)
```bash
bundle exec rspec
```
## Example Usage in Rails Console
After running `rails c`, enter the following:
```bash
player = Player.create(name: "Stephanie")
game = player.games.create
game.frames.count
game.frames.first.pins.count
# Automatically creates 10 frames with 10 pins each
# Update pin states manually for now

manager = BowlingGameManager.new(game)

frame1 = manager.roll(7)
frame1.pins.where(down: true)

# Roll again!
manager.roll(2)
frame.reload.pins.where(down: true).count # -> 9
frame.is_complete # -> true

# Next Frame
frame2 = manager.roll(10)
frame2.is_spare # -> true
frame2.is_complete # -> true

# Check if all frames in the game are complete
game.frames.map { |f| [f.position, f.complete] }

# Check your total score
GameScoreboardService.new(game).calculate_total_score
player.reload.score
```

