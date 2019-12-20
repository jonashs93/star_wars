class PersonDependent < ApplicationRecord

  belongs_to :person
  belongs_to :dependent, polymorphic: true
  # belongs_to :starship, -> { where("person_dependents.dependent_type = ?", 'Starship') }, foreign_key: :dependent_id
  # belongs_to :specie, -> { where("person_dependents.dependent_type = ?", 'Specie') }, foreign_key: :dependent_id
end
