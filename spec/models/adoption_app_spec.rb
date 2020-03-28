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

  describe "instance methods" do
    it "can process application with an array of pet_ids to create joins" do
      application = AdoptionApp.create(name:"Ryan",
                                      address: "1163 S Dudley St.",
                                      city: "Lakewood",
                                      state: "CO",
                                      zip: "80232",
                                      phone_number: "720-771-8977",
                                      description: "I am a good pet owner")
      shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                                 address: "580 McIntyre St",
                                 city:    "Golden",
                                 state:   "CO",
                                 zip:     "80401")
      pet_1 = shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1518900673653-cf9fdd01e430?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
                                     name:            "Tom",
                                     description:     "Squirrel",
                                     approximate_age: "4",
                                     sex:             "Male",
                                     adoptable:       true,)
      pet_2 = shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1548247416-ec66f4900b2e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=963&q=80",
                                     name:            "Jenkyl",
                                     description:     "Black Cat",
                                     approximate_age: "2",
                                     sex:             "Male",
                                     adoptable:       true,)
      pet_3 = shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1580200131976-112bea9d35f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80",
                                     name:            "Amara",
                                     description:     "Elephant",
                                     approximate_age: "33",
                                     sex:             "Female",
                                     adoptable:       false,)
      pet_ids = [pet_1.id.to_s, pet_2.id.to_s, pet_3.id.to_s]

      application.process(pet_ids)
      
      expect(PetAdoptionApp.where(pet_id:pet_1.id).take.adoption_app_id).to eql(application.id)
      expect(PetAdoptionApp.where(pet_id:pet_2.id).take.adoption_app_id).to eql(application.id)
      expect(PetAdoptionApp.where(pet_id:pet_3.id).take.adoption_app_id).to eql(application.id)
    end
  end
end
