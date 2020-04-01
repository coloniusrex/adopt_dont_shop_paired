describe "As a visitor on the edit pet page", type: :feature do
  it "I can see a flash message with what I missed if I fail to complete the form" do
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
    fill_in :name, with: ""
    fill_in :description, with: "Updated Description"
    fill_in :approximate_age, with: "Updated Age"
    fill_in :sex, with: ""
    click_button("Update Pet")

    expect(current_path).to eql("/pets/#{pet_1.id}/edit")
    expect(page).to have_content("Incomplete Submission: Please fill out Name, Sex to complete your form.")
  end
end
