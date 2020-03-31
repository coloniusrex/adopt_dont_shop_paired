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

    it "can approve application and switch pet_adoption_apps approved attribute to true for a pet" do
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

      application.process([pet_1.id])

      pet_adoption_app =  PetAdoptionApp.where(adoption_app_id: application.id, pet_id: pet_1.id).take

      expect(pet_adoption_app.approved).to eql(false)

      application.approve_for(pet_1.id)
      pet_adoption_app.reload

      expect(pet_adoption_app.approved).to eql(true)
    end

    it "can approve for multiple pet ids" do
      application = AdoptionApp.create(name:"Ryan",
                                      address: "1163 S Dudley St.",
                                      city: "Lakewood",
                                      state: "CO",
                                      zip: "80232",
                                      phone_number: "720-771-8977",
                                      description: "I am a good pet owner")
      shelter1 = Shelter.create(name:    "Foothills Animal Shelter",
                                 address: "580 McIntyre St",
                                 city:    "Golden",
                                 state:   "CO",
                                 zip:     "80401")
      pet1 = shelter1.pets.create(image_url:        "https://images.unsplash.com/photo-1518900673653-cf9fdd01e430?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
                                     name:            "Tom",
                                     description:     "Squirrel",
                                     approximate_age: "4",
                                     sex:             "Male",
                                     adoptable:       true,)
      pet2 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)

      application.process([pet1.id, pet2.id])

      pet_adoption_app1 =  PetAdoptionApp.where(adoption_app_id: application.id, pet_id: pet1.id).take
      pet_adoption_app2 =  PetAdoptionApp.where(adoption_app_id: application.id, pet_id: pet2.id).take

      expect(pet_adoption_app1.approved).to eql(false)
      expect(pet_adoption_app2.approved).to eql(false)

      application.approve_multiple([pet1.id, pet2.id])
      pet_adoption_app1.reload
      pet_adoption_app2.reload

      expect(pet_adoption_app1.approved).to eql(true)
      expect(pet_adoption_app2.approved).to eql(true)
    end

    it "can unapprove application and switch pet_adoption_apps approved attribute to false for a pet" do
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
                                     sex:             "Male")

      application.process([pet_1.id])

      pet_adoption_app =  PetAdoptionApp.where(adoption_app_id: application.id, pet_id: pet_1.id).take

      application.approve_for(pet_1.id)
      pet_adoption_app.reload

      expect(pet_adoption_app.approved).to eql(true)

      application.unapprove_for(pet_1.id)
      pet_adoption_app.reload

      expect(pet_adoption_app.approved).to eql(false)
    end
  end
end
