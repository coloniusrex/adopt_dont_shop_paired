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
    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/edit")

    within('.edit_review_form') do
      expect(page).to have_content('Title1')
      expect(page).to have_content(4)
      expect(page).to have_content('Content1')
      expect(page).to_not have_content('www.this.is/your/url')
      fill_in :title, with: 'Title_One'
      fill_in :rating, with: 5
      fill_in :content, with: 'Juicy content.'
      fill_in :image_url, with: 'www.this.is/your/url'
      click_button('Submit Update')
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}")

    within('.reviews_list') do
      expect(page).to have_content('Title_One')
      expect(page).to have_content(5)
      expect(page).to have_content('Juicy content.')
      expect(page).to have_content('www.this.is/your/url')
      expect(page).to_not have_content("Title1")
      expect(page).to_not have_content(4)
    end
  end

  it "If I incorrectly fill out the edit_review form, I see a flash message and redirect to new_review page" do
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
    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/edit")

    within('.edit_review_form') do
      expect(page).to have_content('Title1')
      expect(page).to have_content(4)
      expect(page).to have_content('Content1')
      expect(page).to_not have_content('www.this.is/your/url')
      fill_in :title, with: 'Title_One'
      fill_in :rating, with: 5
      fill_in :content, with: 'Juicy content.'
      fill_in :image_url, with: 'www.this.is/your/url'
      click_button('Submit Update')
    end
  end



  it "I can fill out the form incorrectly then I see a flash message and redirect to edit form" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    review_1 = shelter_1.reviews.create(title: 'Title1', rating: 4, content: 'Content1')

    visit "/shelters/#{shelter_1.id}"

    click_on ('Edit Review')

    within('.edit_review_form') do
      fill_in :title, with: 'Humane Society of Utah'
      fill_in :rating, with: 5
      fill_in :content, with: ''
      fill_in :image_url, with: ''
      click_button('Submit Update')
    end

    expect(page).to have_content("Oopsie Daisy! Review Not Created: Required Information Missing (Title, Rating or Content Missing!)")
    expect(current_path).to eql("/shelters/#{shelter_1.id}/reviews/edit")

    within('.edit_review_form') do
      fill_in :title, with: 'Humane Society of Utah'
      fill_in :rating, with: 5
      fill_in :content, with: 'Content1'
      fill_in :image_url, with: 'image.url/goes/here'
      click_button('Submit Update')
    end

    expect(current_path).to eql("/shelters/#{shelter_1.id}")

  end
end
