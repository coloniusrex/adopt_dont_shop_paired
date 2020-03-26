require 'rails_helper'

RSpec.describe "As a visitor on the landing page", type: :feature do
  it "I can see on the nav bar a favorites indicator with a count of pets in my favorites list" do
    visit "/"
    Capybara.current_session.driver.request.session[:user] = []
    Capybara.current_session.driver.request.session[:user] << 'colin'
    Capybara.current_session.driver.request.session[:user] << 'ryan'
    save_and_open_page
  end
end
