class Reservation < ApplicationRecord
  belongs_to :accomodation
  belongs_to :guest, class_name: "User"
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :correct_chronology, presence: true
  validates :between_different_people, presence: true
  validates :is_not_overlaping, presence: true

  def duration
    self.end_date - self.start_date
  end

  def is_started
    self.start_date < Time.now
  end

  def is_finished
    self.end_date <= Time.now
  end

  def correct_chronology
    self.end_date > self.start_date
  end

  def between_different_people
    self.guest != self.accomodation.administrator
  end

# Méthode qui complète overlaping_reservation? (Accomodation) et qui est appelée dans la méthode is_not_overlaping
  def surrounds?
    surrounded_reservations = []
    self.accomodation.reservations.each do |r|
      if (self.start_date <= r.start_date && self.end_date >= r.end_date)
        surrounded_reservations << r
      end
    end
    surrounded_reservations.length > 0
  end

  def is_not_overlaping
    self.accomodation.overlaping_reservation?(self.start_date) == false && 
    self.accomodation.overlaping_reservation?(self.end_date) == false && 
    surrounds? == false
  end

end

