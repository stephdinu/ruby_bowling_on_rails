class RemovePinsIdFromFrames < ActiveRecord::Migration[8.0]
  def change
    remove_column :frames, :pins_id, :integer
  end
end
