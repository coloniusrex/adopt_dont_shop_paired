class AdoptionApp < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number,
                        :description

  has_many :pet_adoption_apps
  has_many :pets, through: :pet_adoption_apps

  def process(pet_ids)
    pet_ids.map! { |id| id.to_s }
    pet_ids.each do |id|
      PetAdoptionApp.create(adoption_app_id:self.id, pet_id:id)
    end
  end

  def approve_for(pet_id)
    pet_adoption_apps.where(pet_id:pet_id).update(approved:true)
  end

  def approve_multiple(array_of_pet_ids)
    array_of_pet_ids.each do |pet_id|
      approve_for(pet_id)
    end
  end

  def unapprove_for(pet_id)
    pet_adoption_apps.where(pet_id:pet_id).update(approved:false)
  end
end
