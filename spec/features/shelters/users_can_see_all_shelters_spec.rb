require 'rails_helper'

RSpec.describe "As a user on the shelters index page", type: :feature do
  it "I can see all shelters names" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit '/shelters'

    within("#shelter_list_item_#{shelter_1.id}") do
      expect(page).to have_content(shelter_1.name)
    end
    within("#shelter_list_item_#{shelter_2.id}") do
      expect(page).to have_content(shelter_2.name)
    end

  end

  it 'I can click a link that takes you to new shelter form' do
    visit '/shelters'

    click_link('New Shelter')

    expect(current_path).to eql('/shelters/new')
  end

  it "I can see and click an update link for each shelter listing." do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit "/shelters"

    within("#shelter_list_item_#{shelter_1.id}") do
      click_link('Update Shelter')

      expect(current_path).to eql("/shelters/#{shelter_1.id}/edit")
    end

    visit '/shelters'

    within("#shelter_list_item_#{shelter_2.id}") do
      click_link('Update Shelter')

      expect(current_path).to eql("/shelters/#{shelter_2.id}/edit")
    end
  end

  it "I can see and click a delete link for each shelter listing " do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit "/shelters"

    within(".shelters_list") do
      within("#shelter_list_item_#{shelter_2.id}") do
        expect(page).to have_link('Delete Shelter')
      end

      within("#shelter_list_item_#{shelter_1.id}") do
        click_on("Delete Shelter")
      end

      expect(page).to have_no_css("#shelter_list_item_#{shelter_1.id}")
      expect(page).to have_css("#shelter_list_item_#{shelter_2.id}")
    end

    expect(Shelter.exists?(shelter_1.id)).to eql(false)
  end

  it "I can click on a shelter name to take me to that shelters show page" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters"

    within(".shelters_list") do
      within("#shelter_list_item_#{shelter_1.id}") do
        click_link(shelter_1.name)
      end
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}")
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do

    visit "/shelters"

    within(".navbar") do
      click_link("Pets Index")
    end

    expect(current_path).to eql("/pets")
  end

  it "I can click on a link in the nav bar that can take me to the shelters index" do

    visit "/shelters"

    within(".navbar") do
      click_link("Shelters Index")
    end

    expect(current_path).to eql("/shelters")
  end
end
