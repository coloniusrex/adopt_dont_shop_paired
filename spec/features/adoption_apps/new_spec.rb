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
  it "at the top of the form I can select from the favorite pets i'd like to adopt" do
    visit '/adoption_apps/new'

    check "Tom"
    check "Jenkyl"
    check "Amara"
  end

end
