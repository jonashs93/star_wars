class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name, limit: 100
      t.decimal :mass
      t.references :homeworld, foreign_key: true
      t.string :birth_year, limit: 10
      t.timestamps
    end
  end
end
