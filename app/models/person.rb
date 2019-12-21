class Person < ApplicationRecord

  # --- Associations ---

  belongs_to :homeworld, optional: true
  has_many   :dependents, class_name: 'PersonDependent', dependent: :destroy
  has_many   :starships, through: :dependents, source: :dependent, source_type: 'Starship'
  has_many   :species, through: :dependents, source: :dependent, source_type: 'Specie'

  # --- Validates ---

  validates :name, length: { maximum: 100 }
  validates :name, :mass, presence: true
end
