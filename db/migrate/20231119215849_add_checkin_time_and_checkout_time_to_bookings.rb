class AddCheckinTimeAndCheckoutTimeToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :checkin_time, :datetime
    add_column :bookings, :checkout_time, :datetime
  end
end
