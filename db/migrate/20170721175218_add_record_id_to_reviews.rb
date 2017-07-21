class AddRecordIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :record_id, :integer
  end
end
