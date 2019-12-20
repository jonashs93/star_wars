class Person < ApplicationRecord

  # --- Relationships ---

  belongs_to :planet
  has_many   :starships

  # --- Validates ---

  validates :name, limit: 100
  validates :name, :mass, :planet, presence: true
end
