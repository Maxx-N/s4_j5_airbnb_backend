class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :correct_chronology, presence: true
  validates :between_different_people, presence: true

  belongs_to :accomodation
  belongs_to :guest, class_name: "User"

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

end
