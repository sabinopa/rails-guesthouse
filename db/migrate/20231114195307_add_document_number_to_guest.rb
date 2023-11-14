class AddDocumentNumberToGuest < ActiveRecord::Migration[7.0]
  def change
      add_column :guests, :document_number, :string
  end
end
