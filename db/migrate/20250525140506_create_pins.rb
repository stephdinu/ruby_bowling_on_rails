class CreatePins < ActiveRecord::Migration[8.0]
  def change
    create_table :pins do |t|
      t.boolean :down

      t.timestamps
    end
  end
end
