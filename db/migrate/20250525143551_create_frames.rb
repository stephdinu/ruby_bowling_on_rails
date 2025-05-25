class CreateFrames < ActiveRecord::Migration[8.0]
  def change
    create_table :frames do |t|
      t.string :type
      t.integer :tries
      t.references :pins, null: false, foreign_key: true

      t.timestamps
    end
  end
end
