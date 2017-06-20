class AddAttachmentImageToRecords < ActiveRecord::Migration
  def self.up
    change_table :records do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :records, :image
  end
end
