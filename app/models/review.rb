class Review < ApplicationRecord
#every review belongs to a user
  belongs_to :user

  belongs_to :record
end
