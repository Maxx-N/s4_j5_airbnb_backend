class Accomodation < ApplicationRecord
  validates :available_beds,
    presence: true,
    numericality: { greater_than: 0 }
  validates :price, presence: true
  validates :description,
    presence: true,
    length: { minimum: 140 }
  validates_inclusion_of :has_wifi, in: [true, false]
  validates :welcome_message, presence: true

  belongs_to :city
  has_many :reservations
  belongs_to :administrator, class_name: "User"

end
