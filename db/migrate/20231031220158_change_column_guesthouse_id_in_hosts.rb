class ChangeColumnGuesthouseIdInHosts < ActiveRecord::Migration[7.0]
  def change
    change_column_null :hosts, :guesthouse_id, true
  end
end
