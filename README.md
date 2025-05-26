
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
player = Player.create(name: "Alice") # create a new player
game = player.games.create # create a new game

manager = BowlingGameManager.new(game) # create a new manager

# Here is a step-by-step play:
frame1 = manager.roll
knocked_down = frame1.pins.where(down: true).count
standing1 = frame1.pins.where(down: false).count

puts "Frame #{frame.position}, Try #{frame.tries}: #{knocked_down} knocked down, #{standing} standing"

# Roll again (if you can ;) )
manager.roll
frame1.reload.pins.where(down: true).count
frame1.is_complete

frame2 = manager.roll
frame2.is_strike # maybe you were lucky this time!
frame2.is_complete

# Check how many more frames in the game you can play
game.frames.map { |f| [f.position, f.is_complete] }

# Check your total score
GameScoreboardService.new(game).calculate_total_score
player.reload_score

# Continue playing if you feel lucky enough!
```

