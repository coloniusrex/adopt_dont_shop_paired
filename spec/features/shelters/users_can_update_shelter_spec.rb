require 'rails_helper'

RSpec.describe 'A a user o the update shelter page', type: :feature do
  it 'I can update a shelter' do
    shelter = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "shelters/#{shelter.id}/edit"

    within('.update_form') do
      fill_in :name, with: "Updated Shelter Name"
      fill_in :address, with: "Updated Address"
      fill_in :city, with: "Updated City"
      fill_in :state ,with: "Updated State"
      fill_in :zip, with: "Updated Zip"
      click_button('Update Shelter')
    end
    expect(current_path).to eql("/shelters/#{shelter.id}")

    updated_shelter = shelter.reload

    within('#title') do
      expect(page).to have_content(updated_shelter.name)
    end
    within('.shelter_show_address p:first-child') do
      expect(page).to have_content("Address: #{updated_shelter.address}")
    end
    within('.shelter_show_address p:nth-child(2)') do
      expect(page).to have_content("#{updated_shelter.city}, #{updated_shelter.state} #{updated_shelter.zip}")
    end
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}/edit"

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

    visit "/shelters/#{shelter_1.id}"

    within(".navbar") do
      click_link("Shelters Index")
    end

    expect(current_path).to eql("/shelters")
  end
end
