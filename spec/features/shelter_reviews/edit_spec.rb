require 'rails_helper'

RSpec.describe "As a user on the shelter_review edit page", type: :feature do
  it "I can make changes to the pre-populated edit form and click submit to redirect to shelter show page" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    review_1 = shelter_1.reviews.create(title: 'Title1',
                                       rating: 4,
                                      content: 'Content1')

    visit "/shelters/#{shelter_1.id}"

    click_on ('Edit Review')
    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

    within('.field-container') do
      expect(find('#title')['value']).to eql('Title1')
      expect(find('#rating_4')['checked']).to eql('checked')
      expect(find('#content')['value']).to eql('Content1')
      expect(page).to have_no_css('img')

      fill_in :title, with: 'Title_One'
      choose :rating_5
      fill_in :content, with: 'Juicy content.'
      fill_in :image_url, with: "https://knowyourmeme.com/photos/1471040"
      click_button('Submit Update')
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}")

    within("#review-#{review_1.id}") do
      expect(page).to have_content('Title_One')
      expect(page).to have_content(5)
      expect(page).to have_content('Juicy content.')
      expect(find("img")["src"]).to have_content("https://knowyourmeme.com/photos/1471040")
      expect(page).to have_no_content("Title1")
      expect(page).to have_no_content(4)
    end
  end

  it "I can fill out the form incorrectly then I see a flash message and redirect to edit form" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    review_1 = shelter_1.reviews.create(title: 'Title1', rating: 4, content: 'Content1')

    visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

    within('.field-container') do
      fill_in :title, with: 'Humane Society of Utah'
      choose :rating_5
      fill_in :content, with: ''
      click_button('Submit Update')
    end

    expect(page).to have_content("Oopsie Daisy! Review Not Created: Required Information Missing (Title, Rating or Content Missing!)")
    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
  end
end
