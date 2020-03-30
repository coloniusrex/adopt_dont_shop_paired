class PetAdoptionApp < ApplicationRecord
  validates :approved, inclusion: { in: [true, false] }

  belongs_to :pet
  belongs_to :adoption_app
end
