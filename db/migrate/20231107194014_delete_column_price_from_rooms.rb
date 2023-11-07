class DeleteColumnPriceFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :price
  end
end
