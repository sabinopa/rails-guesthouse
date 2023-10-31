class CreateGuesthouses < ActiveRecord::Migration[7.0]
  def change
    create_table :guesthouses do |t|
      t.string :description
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.references :payment_method, null: false, foreign_key: true
      t.boolean :pet_friendly
      t.string :usage_policy
      t.time :checkin
      t.time :checkout
      t.integer :status

      t.timestamps
    end
  end
end
