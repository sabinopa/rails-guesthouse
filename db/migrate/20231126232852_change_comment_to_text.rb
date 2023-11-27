class ChangeCommentToText < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :comment, :text
  end
end
