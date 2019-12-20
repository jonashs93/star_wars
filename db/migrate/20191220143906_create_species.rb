class CreateSpecies < ActiveRecord::Migration[6.0]
  def change
    create_table :species do |t|
      t.string :name, limit: 100
      t.timestamps
    end
  end
end
