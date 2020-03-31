class ChangeApprovedInPet < ActiveRecord::Migration[5.1]
  def change
    change_column_default :pet_adoption_apps, :approved, from:nil, to:false
  end
end
