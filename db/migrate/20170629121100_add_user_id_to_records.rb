class AddUserIdToRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :records, :user_id, :integer
  end
end
