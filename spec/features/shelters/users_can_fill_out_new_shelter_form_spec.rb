require 'rails_helper'

RSpec.describe 'As a user on the new shelter form page', type: :feature do
  it 'I can create a new shelter' do
    visit '/shelters/new'

    within('.new_shelter_form') do
      fill_in :name, with: 'Humane Society of Utah'
      fill_in :address, with: '4242 S 300 W'
      fill_in :city, with: 'Murray'
      fill_in :state, with: 'UT'
      fill_in :zip, with: '84107'
      click_button('Create Shelter')
    end
    expect(current_path).to eql('/shelters')
    expect(page).to have_content(Shelter.last.name)
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do
    visit "/shelters/new"

    within(".navbar") do
      click_link("Pets Index")
    end

    expect(current_path).to eql("/pets")
  end

  it "I can click on a link in the nav bar that can take me to the shelters index" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}/pets"

    within(".navbar") do
      click_link("Shelters Index")
    end

    expect(current_path).to eql("/shelters")
  end
end
