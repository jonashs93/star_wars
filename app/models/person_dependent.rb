class PersonDependent < ApplicationRecord

  # --- Associations ---

  belongs_to :person
  belongs_to :dependent, polymorphic: true

  # --- Validates ---

  validates :person, :dependent, presence: true
end
