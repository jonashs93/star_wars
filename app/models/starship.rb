class Starship < ApplicationRecord

  # --- Relationships ---

  has_many :people

  # --- Validates ---

  validates :name, limit: 100, presence: true
end
