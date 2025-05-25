class RemoveFramesIdFromGames < ActiveRecord::Migration[8.0]
  def change
    remove_column :games, :frames_id, :integer
  end
end
