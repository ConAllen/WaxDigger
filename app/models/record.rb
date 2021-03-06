class Record < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "200x>", thumb: "200x200>" }, default_url: "default.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
#the below validations validates the listing details
  validates :Title, :Label, :Format, :Country, :Released, :Genre, :Tracklist, :Condition, :Original_Price, :Selling_Price, Presence: true
# validates price of record listings
  validates :Original_Price, numericality: { greater_than: 0, less_than: 30}
  validates :Selling_Price, numericality: { greater_than: 0, less_than: 60}
#validates image are present
  validates :image, attachment_presence: true

#a record has many reviews
  has_many :reviews

#the below code links a record to a user.
  belongs_to :user
  # each record can have many orders
  has_many :orders
#the below method states that the max_price can only be increased by 50% of its original selling price.
  def max_price
    (self.Original_Price / 100) * 150 if self.Original_Price
  end
end
