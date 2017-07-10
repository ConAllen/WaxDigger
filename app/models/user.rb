class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
#the below code validates that the name present
  validates :name, presence: true

#the below code tells rails that a user has many records. and that if a user is deleted so is the record
  has_many :records, dependent: :destroy

  has_many :sales, class_name:"Order", foreign_key: "buyer_id"
end
