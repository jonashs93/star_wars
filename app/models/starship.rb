class Starship < ApplicationRecord

  # --- Associations ---

  has_many   :dependents, -> { where(dependent_type: 'Starship') },
                          foreign_key: :dependent_id, class_name: 'PersonDependent',
                          dependent: :destroy
  has_many   :people, through: :dependents

  # --- Validates ---

  validates :name, length: { maximum: 100 }, presence: true
end
