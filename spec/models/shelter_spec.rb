require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
  end

  describe "instance methods" do
    it "can find all adoptable pets" do
      shelter = Shelter.create(name:"Shelter Name", address:"123 S Whatever St",
                              city:"Centennial", state:"CO", zip:"80122")
      horse = shelter.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)
      pig = shelter.pets.create(image_url: "https://", name:"Tom",description:"Pig",
                                  approximate_age: "4", sex:"Male",adoptable: false,)
      squirrel = shelter.pets.create(image_url: "https://", name:"Tom",description:"Squirrel",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      expect(shelter.pets.length).to eql(3)
      expect(shelter.pets[0].id).to eql(horse.id)
      expect(shelter.pets[1].id).to eql(pig.id)
      expect(shelter.pets[2].id).to eql(squirrel.id)
      expect(shelter.adoptable_pets.length).to eql(2)
      expect(shelter.adoptable_pets[0].id).to eql(horse.id)
      expect(shelter.adoptable_pets[1].id).to eql(squirrel.id)
    end
  end
end
