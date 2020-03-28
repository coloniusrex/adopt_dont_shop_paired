require "rails_helper"

RSpec.describe "As a visitor on the new application page", type: :feature do
  it "I can fill out the application and apply for one or more pets" do
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

    visit "/pets/#{pet_1.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/pets/#{pet_2.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/pets/#{pet_3.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit '/application/new'

    within '.application-favorites' do
      check 'Amara'
      check 'Jenkyl'
    end

    within '.application-info' do
      fill_in :name, with: "Ryan"
      fill_in :address, with: "1163 S Dudley St"
      fill_in :city, with: "Lakewood"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80232"
      fill_in :phone_number, with: "720-771-8977"
      fill_in :description, with: "I am a good person"
      click_button "Submit Application"
    end

    expect(page).to have_content("Application Succefully Submitted!")

    application = Application.last

    expect(application.name).to eql("Ryan")
    expect(application.address).to eql("1163 S Dudley St")
    expect(application.city).to eql("Lakewood")
    expect(application.state).to eql("CO")
    expect(application.zip).to eql("80232")
    expect(application.phone_number).to eql("720-771-8977")
    expect(application.description).to eql("I am a good person")

    expect(pet_2.applications).to eql([application])
    expect(pet_3.applications).to eql([application])
  end
end
