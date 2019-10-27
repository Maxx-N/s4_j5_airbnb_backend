class Accomodation < ApplicationRecord
  belongs_to :city
  has_many :reservations
  belongs_to :administrator, class_name: "User"
  
  validates :available_beds,
    presence: true,
    numericality: { greater_than: 0 }
  validates :price, 
    presence: true,
    numericality: { greater_than: 0 }
  validates :description,
    presence: true,
    length: { minimum: 140 }
  validates_inclusion_of :has_wifi, in: [true, false]
  validates :welcome_message, presence: true

  def overlaping_reservation?(datetime)
    # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
    overlap = []
    self.reservations.each do |r|
      overlap << datetime if (datetime > r.start_date && datetime < r.end_date)
    end
    return overlap.length > 0
  end


end
