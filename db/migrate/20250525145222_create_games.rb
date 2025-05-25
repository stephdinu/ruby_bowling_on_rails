class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.references :player, null: false, foreign_key: true
      t.references :frames, null: false, foreign_key: true

      t.timestamps
    end
  end
end
