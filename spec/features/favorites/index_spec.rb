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

  it "I can click on remove all favorited pets I redirect to favorites and see that I have no favorited pets" do
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

    within('.favorites-counter') do
      expect(page).to have_content("Favorites: 2")
    end

    within('.delete-all') do
      click_link 'Remove All Favorited Pets'
    end

    expect(current_path).to eql('/favorites')

    within('.favorites-counter') do
      expect(page).to have_content("Favorites: 0")
    end
  end

  it "I can click on a link for adopting a pet and be taken to a page with a form." do
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

    visit '/favorites'

    within ".adopt-pets" do
      click_link('Adopt Pets')
    end

    expect(current_path).to eql("/adoption_apps/new")
  end

  it "I can see a list of pets that have an adoption application created for them" do
    application = AdoptionApp.create(name:"Ryan",
                                    address: "1163 S Dudley St.",
                                    city: "Lakewood",
                                    state: "CO",
                                    zip: "80232",
                                    phone_number: "720-771-8977",
                                    description: "I am a good pet owner")
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
                                   adoptable:       true,)
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
    pet_ids = [pet_1.id.to_s, pet_2.id.to_s]

    application.process(pet_ids)
    visit '/favorites'

    within(".pets-applied-for") do
      expect(page).to have_link(pet_1.name)
      expect(page).to have_link(pet_2.name)
      expect(page).to have_no_link(pet_3.name)
    end
  end
end
