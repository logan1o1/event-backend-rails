class Category < ApplicationRecord
  validates :category, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, uniqueness: { case_sensitive: false }
end
