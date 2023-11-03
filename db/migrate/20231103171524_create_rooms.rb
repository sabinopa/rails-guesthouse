class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :size
      t.string :max_people
      t.string :price
      t.boolean :bathroom
      t.boolean :balcony
      t.boolean :air_conditioner
      t.boolean :tv
      t.references :guesthouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
