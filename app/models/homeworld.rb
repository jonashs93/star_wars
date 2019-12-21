class Homeworld < ApplicationRecord

  # --- Associations ---

  has_many :people

  # --- Validates ---

  validates :name, length: { maximum: 100 }, presence: true
end
