require 'rails_helper'

RSpec.describe "As a visitor" type: :feature do
  describe "when I have added pets to my favorites list" do
    it "When I click the favorites indicator in the nav bar I am taken to favorites index" do
      visit '/shelters'

      within('.navbar') do
        within('.favorites_counter')
        click_link 'Favorites:'
      end

      expect(current_path).to eql('/favorites')
    end
  end

  describe "when I have no pets in my favorites list" do
    
  end
end
