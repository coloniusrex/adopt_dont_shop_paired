class AddApplicationIdToPet < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :applicant_id, :string
  end
end
