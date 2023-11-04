class AddColumnsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :wardrobe, :boolean
    add_column :rooms, :safe, :boolean
    add_column :rooms, :accessibility, :boolean
    add_column :rooms, :status, :boolean
  end
end
