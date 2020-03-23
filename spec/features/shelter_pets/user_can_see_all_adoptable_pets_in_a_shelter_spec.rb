require "rails_helper"

RSpec.describe "As a user on the shelter pets index page", type: :feature do
  it 'I can see all adoptable pets from with a particular shelter' do
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
    pet_4 = shelter_2.pets.create(image_url:        "https://images.unsplash.com/photo-1580598152173-e5fab42e08a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80",
                                   name:            "Oscar",
                                   description:     "Great Horned Owl",
                                   approximate_age: "12",
                                   sex:             "Female",
                                   adoptable:       true,)

    visit "/shelters/#{shelter_1.id}/pets"
    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        expect(find("img")["src"]).to eql(pet_1.image_url)
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_1.approximate_age)
        expect(page).to have_content(pet_1.sex)
      end
      within("#pet_list_item_#{pet_2.id}") do
        expect(find("img")["src"]).to eql(pet_2.image_url)
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
      end
      expect(page).to have_no_css("#pet_list_item_#{pet_3.id}")
      expect(page).to have_no_css("#pet_list_item_#{pet_4.id}")
    end

  end

  it "I can see and use an update link for each pet" do
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


    visit "/shelters/#{shelter_1.id}/pets"

    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        expect(page).to have_link("Update Pet")
      end
      within("#pet_list_item_#{pet_2.id}") do
        expect(page).to have_link("Update Pet")
      end
      within("#pet_list_item_#{pet_1.id}") do
        click_link("Update Pet")
      end
    end

    expect(current_path).to eql("/pets/#{pet_1.id}/edit")
  end

  it "I can see and use a delete link for each pet" do
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


    visit "/shelters/#{shelter_1.id}/pets"

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

    visit "/shelters/#{shelter_1.id}/pets"

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

    visit "/shelters/#{shelter_1.id}/pets"

    within(".pets_list") do
      within("#pet_list_item_#{pet_1.id}") do
        click_link(pet_1.name)
      end
    end

    expect(current_path).to eql("/pets/#{pet_1.id}")
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}/pets"

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
