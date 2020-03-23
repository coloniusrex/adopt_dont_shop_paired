require "rails_helper"

RSpec.describe "As a user", type: :feature do
  it "i can see a pets image, name, description, approximate age, sex, and adoption status on a show page" do
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

    visit "/pets/#{pet_1.id}"

    expect(page).to have_css("#petimg-#{pet_1.id}")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content("#{pet_1.name} is #{pet_1.adoption_status}")

    visit "/pets/#{pet_2.id}"

    expect(page).to have_css("#petimg-#{pet_2.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.description)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content("#{pet_2.name} is #{pet_2.adoption_status}")
  end

  it "I can update a specific pet" do
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
    click_link("Update Pet")

    expect(current_path).to eql("/pets/#{pet_1.id}/edit")

    fill_in :image_url, with: "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80"
    fill_in :name, with: "Updated Name"
    fill_in :description, with: "Updated Description"
    fill_in :approximate_age, with: "Updated Age"
    fill_in :sex, with: "Updated Sex"
    click_button("Update Pet")
    new_pet = pet_1.reload

    expect(current_path).to eql("/pets/#{new_pet.id}")
    expect(page.find("#petimg-#{new_pet.id}")['src']).to have_content('https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80')
    expect(page).to have_content(new_pet.name)
    expect(page).to have_content(new_pet.description)
    expect(page).to have_content(new_pet.approximate_age)
    expect(page).to have_content(new_pet.sex)
  end

  it "can delete a specific pet" do
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

    expect(Pet.exists?(pet_1.id)).to eql(true)

    click_link('Delete Pet')

    expect(current_path).to eql('/pets')
    expect(Pet.exists?(pet_1.id)).to eql(false)
    expect(page).to have_no_css('img[src*="https://images.unsplash.com/photo-1538083156950-7ad24f318e7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"]')
    expect(page).to have_no_content(pet_1.name)
    expect(page).to have_no_content(pet_1.description)
    expect(page).to have_no_content(pet_1.approximate_age)
    expect(page).to have_no_content(pet_1.sex)
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do
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
    pet_1 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1538083156950-7ad24f318e7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)
    visit "/pets/#{pet_1.id}"

    within(".navbar") do
      click_link("Shelters Index")
    end

    expect(current_path).to eql("/shelters")
  end
end
