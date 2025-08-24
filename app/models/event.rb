class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 1000}
  validates :date, presence: true
  validates :location, presence: true, length: { minimum: 3, maximum: 200}

  validate :date_cannot_be_in_the_past
  validate :date_cannot_be_too_far_in_future

  validates :user, presence: true

  private

  def date_cannot_be_in_the_past
    if date.present? && date < Date.current
      errors.add(:date, "can't be in the past")
    end
  end

  def date_cannot_be_too_far_in_future
    if date.present? && date > 1.year.from_now
      errors.add(:date, "can't be more than 1 year in the future")
    end
  end

end
