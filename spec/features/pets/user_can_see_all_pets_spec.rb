require 'rails_helper'

RSpec.describe "As a user on the pets index page", type: :feature do
  it "I can see a list of all pets image, name, approximate age, sex, and name of shelter location" do
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
    pet_2 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1553854201-29e55f0625f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                   name:            "Moma",
                                   description:     "Pug",
                                   approximate_age: "2",
                                   sex:             "Female",
                                   adoptable:       false)

    visit "/pets"
    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        expect(find('img')['src']).to eql(pet_1.image_url)
        expect(page).to have_content(pet_1.description)
        expect(page).to have_content(pet_1.approximate_age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.shelter.name)
      end
      within("#pet_list_item_#{pet_2.id}") do
        expect(find('img')['src']).to eql(pet_2.image_url)
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.description)
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to have_content(pet_2.shelter.name)
      end
    end
  end

  it "I can see and use an update link for each pet" do
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
    pet_2 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1553854201-29e55f0625f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                   name:            "Moma",
                                   description:     "Pug",
                                   approximate_age: "2",
                                   sex:             "Female",
                                   adoptable:       false)

    visit '/pets'

    within("#pet_list_item_#{pet_1.id}") do
      expect(page).to have_link("Update Pet")
    end
    within("#pet_list_item_#{pet_2.id}") do
      expect(page).to have_link("Update Pet")
    end
    within("#pet_list_item_#{pet_1.id}") do
      click_link("Update Pet")
    end

    expect(current_path).to eql("/pets/#{pet_1.id}/edit")
  end

  it "I can see and use a delete pet link for each pet" do
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
    pet_2 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1553854201-29e55f0625f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                   name:            "Moma",
                                   description:     "Pug",
                                   approximate_age: "2",
                                   sex:             "Female",
                                   adoptable:       false)

    visit '/pets'

    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        expect(page).to have_link("Delete Pet")
      end
      within("#pet_list_item_#{pet_2.id}") do
        expect(page).to have_link("Delete Pet")
      end
      within("#pet_list_item_#{pet_1.id}") do
        click_link("Delete Pet")
      end
    end

    expect(current_path).to eql("/pets")

    within(".pets_list") do
      expect(page).to have_css("#pet_list_item_#{pet_2.id}")
      expect(page).to have_no_css("#pet_list_item_#{pet_1.id}")
    end

    expect(Pet.exists?(pet_1.id)).to eql(false)
  end

  it "I can click on pets shelter location name to take me to the shelter show page" do
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

    visit "/pets"

    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        click_link(pet_1.shelter.name)
      end
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}")
  end

  it "I can click on pet name and go to that pets show page" do
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

    visit "/pets"

    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        click_link(pet_1.name)
      end
    end

    expect(current_path).to eql("/pets/#{pet_1.id}")
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do
    visit "/pets"

    within(".navbar") do
      click_link("Pets Index")
    end

    expect(current_path).to eql("/pets")
  end

  it "I can click on a link in the nav bar that can take me to the shelters index" do
    visit "/pets"

    within(".navbar") do
      click_link("Shelters Index")
    end

    expect(current_path).to eql("/shelters")
  end
end
