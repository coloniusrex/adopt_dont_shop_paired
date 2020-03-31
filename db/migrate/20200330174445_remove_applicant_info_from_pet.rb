class RemoveApplicantInfoFromPet < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :applicant_name, :string
    remove_column :pets, :applicant_id, :string
  end
end
