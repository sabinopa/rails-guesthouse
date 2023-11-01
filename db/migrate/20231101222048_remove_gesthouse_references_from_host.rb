class RemoveGesthouseReferencesFromHost < ActiveRecord::Migration[7.0]
  def change
    remove_reference :hosts, :guesthouse, foreign_key: true, index: false
  end
end
