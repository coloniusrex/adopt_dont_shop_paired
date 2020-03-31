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
    it {should have_many :reviews}
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

    it "can check if any of its pets are pending adoption" do
      shelter = Shelter.create(name:"Shelter Name", address:"123 S Whatever St",
                              city:"Centennial", state:"CO", zip:"80122")
      horse = shelter.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male")
      pig = shelter.pets.create(image_url: "https://", name:"Tom",description:"Pig",
                                  approximate_age: "4", sex:"Male")
      squirrel = shelter.pets.create(image_url: "https://", name:"Tom",description:"Squirrel",
                                  approximate_age: "4", sex:"Male")

      expect(shelter.pets_pending_adoption?).to eql(false)

      horse.make_unadoptable

      expect(shelter.pets_pending_adoption?).to eql(true)
    end

    it "can destroy all depent relationaships, (pets and reviews)" do
      shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
      pet1 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1453227588063-bb302b62f50b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Moma",
                                  description:     "Pug",
                                  approximate_age: "2",
                                  sex:             "Female",
                                  adoptable:       true)

      pet2 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)
      review1 = shelter1.reviews.create(title:    'Greate Shelter',
                                          rating:   5,
                                          content:  'Outstanding, knowledgable and friendly staff.')
      review2 = shelter1.reviews.create(title:    'It\'s OK',
                                          rating:   3,
                                          content:  'I felt as the staff was a little standoff-ish. Maybe I just met them on a bad day.')

      expect(shelter1.pets.present?).to eql(true)
      expect(shelter1.reviews.present?).to eql(true)

      shelter1.destroy_dependencies

      expect(Review.exists?(review1.id)).to eql(false)
      expect(Review.exists?(review2.id)).to eql(false)
      expect(Pet.exists?(pet1.id)).to eql(false)
      expect(Pet.exists?(pet2.id)).to eql(false)
    end
  end
end
