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
    it {should have_many :pet_adoption_apps}
    it {should have_many(:adoption_apps).through(:pet_adoption_apps)}
  end

  describe "instance methods" do
    it "can update the adoption status of a pet to pending" do
      shelter = Shelter.create(name:"Shelter Name", address:"123 S Whatever St",
                              city:"Centennial", state:"CO", zip:"80122")
      horse = shelter.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      horse.make_unadoptable

      expect(horse.adoptable).to eql(false)
    end


    it "can change the pets adoptable status when an application is unapproved" do
      lucky = Pet.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      lucky.make_unadoptable

      expect(lucky.adoptable).to eql(false)

      lucky.make_adoptable

      expect(lucky.adoptable).to eql(true)
    end

    it "can find name of approved applicant" do
      shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
      lucky = shelter1.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)
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
      application1.process([lucky.id])
      application2.process([lucky.id])
      application1.approve_for(lucky.id)

      expect(lucky.approved_applicant_name).to eql(application1.name)

    end

    it "can find an approved applications id through pet_adoption_apps" do
      shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
      lucky = shelter1.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)
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
      application1.process([lucky.id])
      application2.process([lucky.id])
      application1.approve_for(lucky.id)

      expect(lucky.approved_application_id).to eql(application1.id)
    end

    it "can destroy destroy dependencies, pet adoption apps" do
      shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
      lucky = shelter1.pets.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)
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
      pet_adoption_apps1 = PetAdoptionApp.create(adoption_app: application1, pet: lucky)
      pet_adoption_apps2 = PetAdoptionApp.create(adoption_app: application2, pet: lucky)

      expect(lucky.pet_adoption_apps[0]).to eql(pet_adoption_apps1)
      expect(lucky.pet_adoption_apps[1]).to eql(pet_adoption_apps2)

      lucky.destroy_dependencies
      
      expect(PetAdoptionApp.exists?(pet_adoption_apps1.id)).to eql(false)
      expect(PetAdoptionApp.exists?(pet_adoption_apps2.id)).to eql(false)
    end

  end
end
