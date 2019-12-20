class CreatePersonDependents < ActiveRecord::Migration[6.0]
  def change
    create_table :person_dependents do |t|
      t.references :person
      t.references :dependent, polymorphic: true
      t.timestamps
    end
  end
end
