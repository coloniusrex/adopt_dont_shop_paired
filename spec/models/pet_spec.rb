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

    it "can add the applicant name and id to pet" do
      lucky = Pet.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      expect(lucky.applicant_name).to eql(nil)
      expect(lucky.applicant_id).to eql(nil)

      lucky.add_applicant_info("Rhonda", "4")

      expect(lucky.applicant_name).to eql("Rhonda")
      expect(lucky.applicant_id).to eql("4")

    end

    it "can remove the applicant name and id from pet" do
      lucky = Pet.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)


      lucky.add_applicant_info("Rhonda", "4")

      expect(lucky.applicant_name).to eql("Rhonda")
      expect(lucky.applicant_id).to eql("4")

      lucky.delete_applicant_info

      expect(lucky.applicant_name).to eql(nil)
      expect(lucky.applicant_id).to eql(nil)

    end

    it "can change the pets adoptable status when an application is unapproved" do
      lucky = Pet.create(image_url: "https://", name:"Tom",description:"Horse",
                                  approximate_age: "4", sex:"Male",adoptable: true,)

      lucky.make_unadoptable

      expect(lucky.adoptable).to eql(false)

      lucky.make_adoptable

      expect(lucky.adoptable).to eql(true)
    end
  end
end
