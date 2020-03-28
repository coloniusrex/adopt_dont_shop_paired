require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :image_url}
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :approximate_age}
    it {should validate_presence_of :sex}
    it {should validate_inclusion_of(:adoptable).in_array([true, false])}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

  describe "instance methods" do
    it "can present the adoption status of a pet" do
      shelter = Shelter.create(name:"Shelter Name", address:"123 S Whatever St",
                              city:"Centennial", state:"CO", zip:"80122")
      horse = shelter.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)
      pig = shelter.pets.create(image_url: "https://", name:"Tom",description:"Pig",
                                  approximate_age: "4", sex:"Male",adoptable: false,)

      expect(horse.adoption_status).to eql("adoptable")
      expect(pig.adoption_status).to eql("pending adoption")
    end
  end
end
