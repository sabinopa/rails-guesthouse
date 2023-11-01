class AddHostToGuesthouse < ActiveRecord::Migration[7.0]
  def change
    add_reference :guesthouses, :host, null: false, foreign_key: true
  end
end
