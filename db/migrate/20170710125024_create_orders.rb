class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :town_or_city
      t.string :state_or_county
      t.string :post_or_zip_code
      t.string :country

      t.timestamps
    end
  end
end
