class Order < ApplicationRecord
  #the below validates the form fields
  validates :address,:town_or_city,:state_or_county,:post_or_zip_code,:country, presence: true

  belongs_to :record

  # the below code tells rails that the relationship is two sided. a user can be a buyer or a seller
  belongs_to :buyer, class_name:"User"
  belongs_to :seller, class_name:"User"
end
