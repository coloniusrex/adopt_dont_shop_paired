class AddApprovedToPetsAdoptionApps < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_adoption_apps, :approved, :boolean
  end
end
