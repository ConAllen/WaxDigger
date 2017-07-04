class Record < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "200x>", thumb: "200x200>" }, default_url: "default.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
#the below validations validates the listing details
  validates :Title, :Label, :Format, :Country, :Released, :Genre, :Tracklist, :Condition, :Original_Price, :Selling_Price, Presence: true
# validates price of listings ** need to fix this
  validates :Original_Price, numericality: { greater_than: 0, less_than: 18}
  validates :Selling_Price, numericality: { greater_than: 0, less_than: 50}
#validates image are present
  validates :image, attachment_presence: true

#the below code links a record to a user.
  belongs_to :user
end
