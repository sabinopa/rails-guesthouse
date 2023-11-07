class CreateCustomPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_prices do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :price
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
