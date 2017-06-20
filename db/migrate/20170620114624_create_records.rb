class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.string :Title
      t.string :Label
      t.text :Format
      t.string :Country
      t.string :Released
      t.string :Genre
      t.text :Tracklist
      t.string :Condition
      t.decimal :Original_Price
      t.decimal :Selling_Price

      t.timestamps
    end
  end
end
