class PetAdoptionApp < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_app
end
