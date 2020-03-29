class CreatePetAdoptionApp < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_adoption_apps do |t|
      t.references :adoption_app, foreign_key: true
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
