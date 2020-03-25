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
    within('.shelter_show_address p:first-child') do
      expect(page).to have_content("Address: #{shelter_1.address}")
    end
    within('.shelter_show_address p:nth-child(2)') do
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

    within('.reviews_list') do
      within("#review_#{review_1.id}") do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.content)
      end
      within("#review_#{review_2.id}") do
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

    within('.reviews_list') do
      within("#review_#{review_1.id}") do
        expect(page).to have_link('Edit Review')
      end
      within("#review_#{review_2.id}") do
        expect(page).to have_link('Edit Review')
      end
      within("#review_#{review_1.id}") do
        click_link('Edit Review')
      end
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/edit")
  end
end
