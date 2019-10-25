class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :accomodation
  belongs_to :guest, class_name: "User"

end
