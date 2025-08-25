class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { minimum: 3, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 1000}
  validates :date, presence: true
  validates :location, presence: true, length: { minimum: 3, maximum: 200}
  validates :poster_url, presence: true, format: { with: URI::regexp, message: "must be a valid URL" }
  validates :category, presence: true
  validates :user, presence: true

  validate :date_cannot_be_in_the_past
  validate :date_cannot_be_too_far_in_future

  has_many :participants, dependent: :destroy

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
