require "rails_helper"

RSpec.describe "On adoption apps show page", type: :feature do
  it "I can see the applicants name, address, city, state, zip, phone_number, description, and names of all pets" do
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
                                   adoptable:       true,)

    pet_ids = [pet_1.id.to_s, pet_2.id.to_s]

    application.process(pet_ids)

    visit "/adoption_apps/#{application.id}"

    within(".app-info") do
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip)
      expect(page).to have_content(application.phone_number)
      expect(page).to have_content(application.description)
    end
    within(".app-pet-list") do
      expect(page).to have_link(pet_1.name)
      expect(page).to have_link(pet_2.name)
      expect(page).to have_no_link(pet_3.name)
    end
  end

  it "I can click a link next to each pet to approve the application for and am taken to the pets show page" do
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
                                   adoptable:       true,)

    application.process([pet_1.id, pet_2.id, pet_3.id])
    visit "/adoption_apps/#{application.id}"

    within('.app-pet-list') do
      within("#app-pet-#{pet_1.id}") do
        expect(page).to have_link('Approve Application')
      end
      within("#app-pet-#{pet_2.id}") do
        expect(page).to have_link('Approve Application')
      end
      within("#app-pet-#{pet_3.id}") do
        click_link 'Approve Application'
      end
    end

    expect(current_path).to eql("/pets/#{pet_3.id}")
  end

  it "I can click on approve app for more than one pet" do
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
                                   adoptable:       true,)

    application.process([pet_1.id, pet_2.id, pet_3.id])

    visit "/adoption_apps/#{application.id}"

    within("#app-pet-#{pet_1.id}") do
      click_link 'Approve Application'
    end

    expect(current_path).to eql("/pets/#{pet_1.id}")

    within('.pet-show-info') do
      expect(page).to have_content("#{pet_1.name} is pending adoption, on hold for #{pet_1.applicant_name}")
    end

    visit "/adoption_apps/#{application.id}"

    within("#app-pet-#{pet_2.id}") do
      click_link 'Approve Application'
    end

    expect(current_path).to eql("/pets/#{pet_2.id}")

    within('.pet-show-info') do
      expect(page).to have_content("#{pet_2.name} is pending adoption, on hold for #{pet_2.applicant_name}")
    end

    visit "/adoption_apps/#{application.id}"

    within("#app-pet-#{pet_3.id}") do
      click_link 'Approve Application'
    end

    expect(current_path).to eql("/pets/#{pet_3.id}")

    within('.pet-show-info') do
      expect(page).to have_content("#{pet_3.name} is pending adoption, on hold for #{pet_3.applicant_name}")
    end

  end

  it "I can no longer approve an app if another app is currently approved on this pet" do
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

    application1.process([pet_1.id])
    application2.process([pet_1.id])

    visit "/adoption_apps/#{application1.id}"

    within("#app-pet-#{pet_1.id}") do
      click_link 'Approve Application'
    end

    visit "/adoption_apps/#{application2.id}"

    within("#app-pet-#{pet_1.id}") do
      expect(page).to have_no_link('Approve Application')
      expect(page).to have_content('Another application is currently pending.')
    end
  end

  it "I can unapprove an application and see the pets show page adoption status has changed" do
    application = AdoptionApp.create(name:"Colin",
                                    address: "8397 Mayfair Lane",
                                    city: "Chevy Chase",
                                    state: "MD",
                                    zip: "20815",
                                    phone_number: "303-675-0987",
                                    description: "I am the best pet owner")

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

    visit "/adoption_apps/#{application.id}"

    within("#app-pet-#{pet_1.id}") do
      click_link 'Approve Application'
    end

    visit "/adoption_apps/#{application.id}"

    within("#app-pet-#{pet_1.id}") do
      click_link 'Un-Approve Application'
    end

    expect(current_path).to eql("/adoption_apps/#{application.id}")

    within("#app-pet-#{pet_1.id}") do
      expect(page).to have_link('Approve Application')
    end

    visit "/pets/#{pet_1.id}"

    within('.pet-show-info') do
      expect(page).to have_content("#{pet_1.name} is adoptable")
    end
  end
end
