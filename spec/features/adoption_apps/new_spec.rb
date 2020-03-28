require "rails_helper"

RSpec.describe "As a visitor on the new adoption apps page", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    @pet_1 = @shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1518900673653-cf9fdd01e430?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
                                   name:            "Tom",
                                   description:     "Squirrel",
                                   approximate_age: "4",
                                   sex:             "Male",
                                   adoptable:       true,)
    @pet_2 = @shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1548247416-ec66f4900b2e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=963&q=80",
                                   name:            "Jenkyl",
                                   description:     "Black Cat",
                                   approximate_age: "2",
                                   sex:             "Male",
                                   adoptable:       true,)
    @pet_3 = @shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1580200131976-112bea9d35f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80",
                                   name:            "Amara",
                                   description:     "Elephant",
                                   approximate_age: "33",
                                   sex:             "Female",
                                   adoptable:       false,)

    visit "/pets/#{@pet_1.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/pets/#{@pet_2.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/pets/#{@pet_3.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end
  end

  it "I can fill out form with favorite selection, name, address, city, state, zip, phone number, and description and submit app" do
    visit '/adoption_apps/new'

    within('.favorites-selection') do
      check "Jenkyl"
      check "Amara"
    end

    within('.adoption-info') do
      fill_in :name, with: "Ryan"
      fill_in :address, with: "1163 S Dudley St"
      fill_in :city, with: "Lakewood"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80232"
      fill_in :phone_number, with: "720-771-8977"
      fill_in :description, with: "I am an amazing pet owner."
    end
    click_button 'Submit Adoption Application'

    expect(current_path).to eql('/favorites')
    expect(page).to have_content("Adoption Application Successfully Submitted")
    within("#favorite-#{@pet_1.id}") do
      expect(page).to have_content(@pet_1.name)
    end
    expect(page).to have_no_content(@pet_2.name)
    expect(page).to have_no_content(@pet_3.name)

    application = AdoptionApp.last

    expect(application.name).to eql("Ryan")
    expect(application.address).to eql("1163 S Dudley St")
    expect(application.city).to eql("Lakewood")
    expect(application.state).to eql("CO")
    expect(application.zip).to eql("80232")
    expect(application.phone_number).to eql("720-771-8977")
    expect(application.description).to eql("I am an amazing pet owner.")

    @pet_1.reload
    @pet_2.reload
    @pet_3.reload

    expect(@pet_1.adoption_apps).to eql([])
    expect(@pet_2.adoption_apps).to eql([application])
    expect(@pet_3.adoption_apps).to eql([application])
  end
end
