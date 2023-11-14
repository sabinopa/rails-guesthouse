class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :bathroom
      t.string :balcony
      t.string :air_conditioner
      t.string :tv
      t.string :wardrobe
      t.string :safe
      t.string :accessibility

      t.timestamps
    end
  end
end
