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

    it "can count total count of pets in shelter" do
      shelter = Shelter.create(name:"Shelter Name", address:"123 S Whatever St",
                              city:"Centennial", state:"CO", zip:"80122")

      expect(shelter.pet_count).to eql(0)

      horse = shelter.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      expect(shelter.pet_count).to eql(1)

      pig = shelter.pets.create(image_url: "https://", name:"Tom",description:"Pig",
                                  approximate_age: "4", sex:"Male",adoptable: false,)

      expect(shelter.pet_count).to eql(2)

      squirrel = shelter.pets.create(image_url: "https://", name:"Tom",description:"Squirrel",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      expect(shelter.pet_count).to eql(3)
    end

    it "can average all the review ratings for shelter" do
      shelter1 = Shelter.create(name:"Shelter Name", address:"123 S Whatever St",
                              city:"Centennial", state:"CO", zip:"80122")
      review1 = shelter1.reviews.create(title: 'Title1', rating: 4, content: 'Content1')
      review2 = shelter1.reviews.create(title: 'Title2', rating: 5, content: 'Content2')

      expect(shelter1.average_rating.round(1)).to eql(4.5)

      review3 = shelter1.reviews.create(title: 'Title2', rating: 1, content: 'Content2')
      review4 = shelter1.reviews.create(title: 'Title2', rating: 3, content: 'Content2')

      expect(shelter1.average_rating.round(1)).to eql(3.3)

      review5 = shelter1.reviews.create(title: 'Title2', rating: 3, content: 'Content2')
      review6 = shelter1.reviews.create(title: 'Title2', rating: 3, content: 'Content2')

      expect(shelter1.average_rating.round(1)).to eql(3.2)

    end

    it "can count total applications on file for shelter" do
      shelter = Shelter.create(name:    "Foothills Animal Shelter",
                                 address: "580 McIntyre St",
                                 city:    "Golden",
                                 state:   "CO",
                                 zip:     "80401")
      pet1 = shelter.pets.create(image_url:       "https://images.unsplash.com/photo-1453227588063-bb302b62f50b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Moma",
                                  description:     "Pug",
                                  approximate_age: "2",
                                  sex:             "Female",
                                  adoptable:       true)

      pet2 = shelter.pets.create(image_url:       "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)
      application1 = AdoptionApp.create(name:"Ryan",
                                      address: "23 Cedarwood Road",
                                      city: "Omaha",
                                      state: "NE",
                                      zip: "68107",
                                      phone_number: "456-908-7656",
                                      description: "I am a good pet owner")
      application2 = AdoptionApp.create(name:"Colin",
                                      address: "8397 Mayfair Lane",
                                      city: "Chevy Chase",
                                      state: "MD",
                                      zip: "20815",
                                      phone_number: "303-675-0987",
                                      description: "I am the best pet owner")


      application1.process([pet1.id, pet2.id])
      expect(shelter.total_applications).to eql(0)


      expect(shelter.total_applications).to eql(1)

      application1.process([pet2.id])

      expect(shelter.total_applications).to eql(2)

    end
  end
end
