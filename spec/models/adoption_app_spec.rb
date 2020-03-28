require "rails_helper"

RSpec.describe AdoptionApp, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should have_many :pet_adoption_apps}
    it {should have_many(:pets).through(:pet_adoption_apps)}
  end
end
