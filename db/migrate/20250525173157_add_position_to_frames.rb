class AddPositionToFrames < ActiveRecord::Migration[8.0]
  def change
    add_column :frames, :position, :integer
  end
end
