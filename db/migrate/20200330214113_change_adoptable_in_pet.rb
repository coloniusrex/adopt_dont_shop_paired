class ChangeAdoptableInPet < ActiveRecord::Migration[5.1]
  def change
    change_column_default :pets, :adoptable, from:nil, to:true
  end
end
