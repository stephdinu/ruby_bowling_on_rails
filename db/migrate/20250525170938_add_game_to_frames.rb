class AddGameToFrames < ActiveRecord::Migration[8.0]
  def change
    add_reference :frames, :game, null: false, foreign_key: true
  end
end
