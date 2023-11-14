class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number_guests
      t.references :host, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: true
      t.string :code
      t.references :room, null: false, foreign_key: true
      t.integer :status
      t.float :prices

      t.timestamps
    end
  end
end
