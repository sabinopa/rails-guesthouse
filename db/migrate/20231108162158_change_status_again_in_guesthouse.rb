class ChangeStatusAgainInGuesthouse < ActiveRecord::Migration[7.0]
  def change
    change_column :guesthouses, :status, :integer, default: 0
  end
end
