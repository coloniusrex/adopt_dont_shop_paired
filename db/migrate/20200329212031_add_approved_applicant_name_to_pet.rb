class AddApprovedApplicantNameToPet < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :applicant_name, :string
  end
end
