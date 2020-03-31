require 'rails_helper'

RSpec.describe 'As a user the shelter show page', type: :feature do
  it 'I can see shelters name, address, city, state, and zip' do
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

    visit("/shelters/#{shelter_1.id}")

    within('#title') do
      expect(page).to have_content(shelter_1.name)
    end
    within('.shelter-show-address p:first-child') do
      expect(page).to have_content("Address: #{shelter_1.address}")
    end
    within('.shelter-show-address p:nth-child(2)') do
      expect(page).to have_content("#{shelter_1.city}, #{shelter_1.state} #{shelter_1.zip}")
    end
    expect(page).to have_no_content(shelter_2.name)
  end

  it 'I can see a update shelter link' do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link('Update Shelter')

    click_link('Update Shelter')

    expect(current_path).to eql("/shelters/#{shelter_1.id}/edit")
  end

  it "I can delete a shelter" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: " 580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit "/shelters/#{shelter_1.id}"

    click_link('Delete Shelter')

    expect(current_path).to eql('/shelters')
    expect(page).to have_content("#{shelter_2.name}")
    expect(page).to have_no_content("#{shelter_1.name}")

    expect(Shelter.exists?(shelter_1.id)).to eql(false)
  end

  it "I can click on a link in the nav bar that can take me to the pet index" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}"

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

  it "I can click on shelters pets link and it will take me there" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}"

    click_link("Shelter's Pets")

    expect(current_path).to eql("/shelters/#{shelter_1.id}/pets")
  end

  it "I can see a list of reviews for this shelter that have title,rating,content, and opt. picture" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    review_1 = shelter_1.reviews.create(title: 'Title1', rating: 4, content: 'Content1')
    review_2 = shelter_1.reviews.create(title: 'Title2', rating: 5, content: 'Content2',
      image_url: 'https://i.kym-cdn.com/photos/images/facebook/001/471/040/2aa.jpeg')

    visit "/shelters/#{shelter_1.id}"

    within('.reviews-list') do
      within("#review-#{review_1.id}") do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.content)
      end
      within("#review-#{review_2.id}") do
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_2.rating)
        expect(page).to have_content(review_2.content)
        expect(page.find("img")["src"]).to eql(review_2.image_url)
      end
    end
  end

  it "I can click on a link beside each review to take me to the edit review page" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    review_1 = shelter_1.reviews.create(title: 'Title1', rating: 4, content: 'Content1')
    review_2 = shelter_1.reviews.create(title: 'Title2', rating: 5, content: 'Content2',
      image_url: 'https://i.kym-cdn.com/photos/images/facebook/001/471/040/2aa.jpeg')

    visit "/shelters/#{shelter_1.id}"

    within('.reviews-list') do
      within("#review-#{review_1.id}") do
        expect(page).to have_link('Edit Review')
      end
      within("#review-#{review_2.id}") do
        expect(page).to have_link('Edit Review')
      end
      within("#review-#{review_1.id}") do
        click_link('Edit Review')
      end
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
  end

  it "I can not delete this shelter if it has pets with pending status" do
    shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
    pet1 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1453227588063-bb302b62f50b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                name:            "Moma",
                                description:     "Pug",
                                approximate_age: "2",
                                sex:             "Female",
                                adoptable:       true)

    pet2 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80",
                                name:            "Charlie",
                                description:     "Yello Lab",
                                approximate_age: "6",
                                sex:             "Male",
                                adoptable:       true)

    pet2.make_unadoptable

    visit "/shelters/#{shelter1.id}"

    within('.shelter-show-links') do
      click_link('Delete Shelter')
    end

    expect(current_path).to eql("/shelters/#{shelter1.id}")

    expect(page).to have_content("Can not delete shelter. Pet adoption currently pending.")
  end

  it "I can delete shelter as long as all pets do not have approved applications" do
    shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
    pet1 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1453227588063-bb302b62f50b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                name:            "Moma",
                                description:     "Pug",
                                approximate_age: "2",
                                sex:             "Female",
                                adoptable:       true)

    pet2 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80",
                                name:            "Charlie",
                                description:     "Yello Lab",
                                approximate_age: "6",
                                sex:             "Male",
                                adoptable:       true)
    shelter1.reviews.create(title:    'Greate Shelter',
                                        rating:   5,
                                        content:  'Outstanding, knowledgable and friendly staff.')
    shelter1.reviews.create(title:    'It\'s OK',
                                        rating:   3,
                                        content:  'I felt as the staff was a little standoff-ish. Maybe I just met them on a bad day.')
    application1 = AdoptionApp.create(name:"Ryan",
                                    address: "23 Cedarwood Road",
                                    city: "Omaha",
                                    state: "NE",
                                    zip: "68107",
                                    phone_number: "456-908-7656",
                                    description: "I am a good pet owner")
    application1.process([pet1.id])

    visit "/shelters/#{shelter1.id}"

    expect(shelter1.pets_pending_adoption?).to eql(false)

    within(".shelter-show-links") do
      click_link("Delete Shelter")
    end

    expect(Shelter.exists?(shelter1.id)).to eql(false)
  end

  it "I can delete a shelter and expect that the reviews are deleted as well." do
    shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")
    review1 = shelter1.reviews.create(title:    'Greate Shelter',
                                        rating:   5,
                                        content:  'Outstanding, knowledgable and friendly staff.')
    review2 = shelter1.reviews.create(title:    'It\'s OK',
                                        rating:   3,
                                        content:  'I felt as the staff was a little standoff-ish. Maybe I just met them on a bad day.')

    visit "/shelters/#{shelter1.id}"

    expect(Review.exists?(review1.id)).to eql(true)
    expect(Review.exists?(review2.id)).to eql(true)

    within(".shelter-show-links") do
      click_link("Delete Shelter")
    end

    expect(Review.exists?(review1.id)).to eql(false)
    expect(Review.exists?(review2.id)).to eql(false)
  end
end
