require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I see a favorites count indicator in the nav bar on any page" do
    visit "/shelters"

    within('.navbar') do
      within('.favorites-counter') do
        expect(page).to have_content('Favorites: 0')
      end
    end
  end

  it "When I click the favorites indicator in the nav bar I am taken to favorites index" do
    visit '/shelters'

    within('.navbar') do
      within('.favorites_counter')
      click_link 'Favorites:'
    end

    expect(current_path).to eql('/favorites')
  end

  describe "When I visit a pets show page" do
    it "I can click a button to add a pet to my favorites list" do
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
      visit "/pets/#{pet_1.id}"

      within('.navbar') do
        within('.favorites-counter') do
          expect(page).to have_content('Favorites: 0')
        end
      end

      within('.pet-show-links') do
        click_link 'Favorite Pet'
      end

      expect(current_path).to eql("/pets/#{pet_1.id}")

      within('.navbar') do
        within('.favorites-counter') do
          expect(page).to have_content('Favorites: 1')
        end
      end
    end

    it "I can see a flash message after clicking on favorite pet" do
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
      visit "/pets/#{pet_1.id}"

      within('.pet-show-links') do
        click_link 'Favorite Pet'
      end

      expect(page).to have_content('You successfully added a pet to your favorites list!')
    end

    it "I can see an unfavorite link on favorited pets show page, after clicking it is removed with flash notice" do
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
      visit "/pets/#{pet_1.id}"

      within('.navbar') do
        within('.favorites-counter') do
          expect(page).to have_content('Favorites: 0')
        end
      end

      within('.pet-show-links') do
        click_link 'Favorite Pet'
      end

      within('.navbar') do
        within('.favorites-counter') do
          expect(page).to have_content('Favorites: 1')
        end
      end

      within('.pet-show-links') do
        click_link 'Un-Favorite Pet'
      end
      expect(current_path).to eql("/pets/#{pet_1.id}")
      expect(page).to have_content("Successfully Removed Pet from Favorites")

      within('.navbar') do
        within('.favorites-counter') do
          expect(page).to have_content('Favorites: 0')
        end
      end

    end
  end
end
