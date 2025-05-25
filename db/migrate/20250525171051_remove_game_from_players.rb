class RemoveGameFromPlayers < ActiveRecord::Migration[8.0]
  def change
    remove_reference :players, :game, index: true
  end
end
