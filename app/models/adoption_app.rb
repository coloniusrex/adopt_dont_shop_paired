class AdoptionApp < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number,
                        :description

  has_many :pet_adoption_apps
  has_many :pets, through: :pet_adoption_apps
end
