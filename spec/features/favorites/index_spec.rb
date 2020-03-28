require "rails_helper"

describe "As a user on the favorites index page", type: :feature do
  it "I can see all of my favorite pets." do
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

    within '.pet-show-container' do
      within '.pet-show-links' do
        click_link 'Favorite Pet'
      end
    end

    visit "/pets/#{pet_2.id}"

    within '.pet-show-container' do
      within '.pet-show-links' do
        click_link 'Favorite Pet'
      end
    end

    visit '/favorites'

    within '.list' do
      within "#favorite-#{pet_1.id}" do
        expect(page).to have_link(pet_1.name)
        expect(find('img')['src']).to eql(pet_1.image_url)
      end
    end
    within '.list' do
      within "#favorite-#{pet_2.id}" do
        expect(page).to have_link(pet_2.name)
        expect(find('img')['src']).to eql(pet_2.image_url)
      end
    end

    expect(page).to have_no_content(pet_3.name)
  end

  it "I can click on the pets name and be taken to their show page." do
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
    visit "/pets/#{pet_1.id}"

    within '.pet-show-container' do
      within '.pet-show-links' do
        click_link 'Favorite Pet'
      end
    end

    visit "/favorites"

    within '.list' do
      within "#favorite-#{pet_1.id}" do
        click_link(pet_1.name)
      end
    end

    expect(current_path).to eql("/pets/#{pet_1.id}")
  end

  it "I can remove favorites from favorite page and be redirected back to favorite" do
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

    visit "/pets/#{pet_1.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/pets/#{pet_2.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/favorites"

    within("#favorite-#{pet_1.id}") do
      expect(page).to have_link("Un-Favorite Pet")
    end

    within("#favorite-#{pet_2.id}") do
      expect(page).to have_link("Un-Favorite Pet")
    end

    within("#favorite-#{pet_1.id}") do
      click_link "Un-Favorite Pet"
    end

    expect(current_path).to eql("/favorites")

    within("#favorite-#{pet_2.id}") do
      expect(page).to have_link("Un-Favorite Pet")
    end

    expect(page).to have_no_css("#favorite-#{pet_1.id}")

  end

  it "If my favorites list is empty I see text indicating that" do
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

    visit '/favorites'

    expect(page).to have_content("You have no favorite pets :(")

    visit "/pets/#{pet_1.id}"

    within('.pet-show-links') do
      click_link('Favorite Pet')
    end

    visit "/favorites"

    expect(page).to have_no_content("You have no favorite pets :(")
  end
end
