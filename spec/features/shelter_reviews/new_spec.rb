require "rails_helper"

RSpec.describe "As a user on the new shelter_review page", type: :feature do
  it "I can fill out a form with title, rating, content, and optional image_url" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}"

    click_link("Create Review")

    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/new")
    within('.field-container') do
      fill_in :title, with: "Title1"
      choose "rating_3"
      fill_in :content, with: "Some content for shits and giggles"
      fill_in :image_url, with: "https://knowyourmeme.com/photos/1471040"
      click_button ('Submit Review')
    end
    expect(current_path).to eql("/shelters/#{shelter_1.id}")

    review = shelter_1.reviews.last

    within("#review-#{review.id}") do
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.content)
      expect(page.find("img")["src"]).to eql(review.image_url)
    end
  end

  it "If I incorrectly fill out the new_review form, I see a flash message and redirect to new_review page" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "/shelters/#{shelter_1.id}/reviews/new"

    within('.field-container') do
      fill_in :title, with: "Title1"
      fill_in :content, with: "Some content for shits and giggles"
      fill_in :image_url, with: "https://knowyourmeme.com/photos/1471040"
      click_button ('Submit Review')
    end

    expect(page).to have_content("Oopsie Daisy! Review Not Created: Required Information Missing (Title, Rating or Content Missing!)")
    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/new")
  end
end
