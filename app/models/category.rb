class Category < ApplicationRecord
  validates :category, presence: true

  validates :category, uniqueness: { case_sensitive: false }
end
