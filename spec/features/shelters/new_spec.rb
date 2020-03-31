require 'rails_helper'

RSpec.describe 'As a user on the new shelter form page', type: :feature do
  it 'I can create a new shelter' do
    visit '/shelters/new'

    within('.new-shelter-form') do
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

  it "I can see a flash message with the missing fields when I fill out a form incomplete" do
    visit "/shelters/new"

    within('.new-shelter-form') do
      fill_in :name, with: 'Humane Society of Utah'
      fill_in :address, with: '4242 S 300 W'
      fill_in :city, with: ''
      fill_in :state, with: 'UT'
      fill_in :zip, with: ''
      click_button('Create Shelter')
    end

    expect(current_path).to eql("/shelters/new")

    expect(page).to have_content("Incomplete Submission: Please fill out City, Zip to complete your form.")

    within('.new-shelter-form') do
      fill_in :name, with: ''
      fill_in :address, with: ''
      fill_in :city, with: 'Denver'
      fill_in :state, with: ''
      fill_in :zip, with: '80203'
      click_button('Create Shelter')
    end

    expect(current_path).to eql("/shelters/new")

    expect(page).to have_content("Incomplete Submission: Please fill out Name, Address, State to complete your form.")

  end
end
