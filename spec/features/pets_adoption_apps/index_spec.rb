require "rails_helper"

RSpec.describe "As a visitor on pets adoption apps index page", type: :feature do
  it "I can see list that names the applicants for this pet." do
    application_1 = AdoptionApp.create(name:"Ryan",
                                    address: "1163 S Dudley St.",
                                    city: "Lakewood",
                                    state: "CO",
                                    zip: "80232",
                                    phone_number: "720-771-8977",
                                    description: "I am a good pet owner")
    application_2 = AdoptionApp.create(name:"Colin",
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
    pet_1 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1538083156950-7ad24f318e7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)

    application_1.process([pet_1.id.to_s])
    application_2.process([pet_1.id.to_s])

    visit ("/pets/#{pet_1.id}/adoption_apps")

    within(".applicants-list") do
      expect(page).to have_link(application_1.name)
      expect(page).to have_link(application_2.name)

      click_link(application_1.name)
    end

    expect(current_path).to eql("/adoption_apps/#{application_1.id}")
  end

  it "I can see a message that no applications exist for this pet currently" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    pet_1 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1538083156950-7ad24f318e7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)
    application_1 = AdoptionApp.create(name:"Ryan",
                                      address: "1163 S Dudley St.",
                                      city: "Lakewood",
                                      state: "CO",
                                      zip: "80232",
                                      phone_number: "720-771-8977",
                                      description: "I am a good pet owner")

    visit "/pets/#{pet_1.id}/adoption_apps"

    within('.no-applicants') do
      expect(page).to have_content("No applications submitted for this pet :(")
    end

    application_1.process([pet_1.id])

    visit current_path

    expect(page).to have_no_css('.no-applicants')
    expect(page).to have_css('.applicants-list')
  end
end
