class ChangeStatusInRooms < ActiveRecord::Migration[7.0]
  def change
    change_column :rooms, :status, :integer, default: 0
  end
end
