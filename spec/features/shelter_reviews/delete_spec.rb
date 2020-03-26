require 'rails_helper'

RSpec.describe "As a user on the shelter show page" do
  it "I can click delete next to any review, and I see the same page with that review missing" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    review_1 = shelter_1.reviews.create(title: 'Title1', rating: 4, content: 'Content1')
    review_2 = shelter_1.reviews.create(title: 'Title2', rating: 5, content: 'ContentestoDos')

    visit "/shelters/#{shelter_1.id}"

    within('.reviews-list') do
      within("#review-#{review_1.id}") do
        expect(page).to have_link('Delete Review')
      end
      within("#review-#{review_2.id}") do
        expect(page).to have_link('Delete Review')
      end
      within("#review-#{review_1.id}") do
        click_link('Delete Review')
      end
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}")

    within(".reviews-list") do
      expect(page).to have_no_content('Title1')
      expect(page).to have_no_content(4)
      expect(page).to have_no_content("Content1")
      within("#review-#{review_2.id}") do
        expect(page).to have_content('Title2')
        expect(page).to have_content(5)
        expect(page).to have_content('ContentestoDos')
      end
    end
    expect(Review.exists?(review_1.id)).to eql(false)
  end
end
