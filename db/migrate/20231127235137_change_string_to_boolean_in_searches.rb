class ChangeStringToBooleanInSearches < ActiveRecord::Migration[7.0]
  def change
    change_column :searches, :bathroom, :boolean
    change_column :searches, :balcony, :boolean
    change_column :searches, :air_conditioner, :boolean
    change_column :searches, :tv, :boolean
    change_column :searches, :wardrobe, :boolean
    change_column :searches, :safe, :boolean
    change_column :searches, :accessibility, :boolean
  end
end
