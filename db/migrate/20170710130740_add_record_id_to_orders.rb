class AddRecordIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :record_id, :integer
  end
end
