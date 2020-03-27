
 it "When I click the favorites indicator in the nav bar I am taken to favorites index" do
   visit '/shelters'

   within('.navbar') do
     within('.favorites_counter')
      click_link 'Favorites:'
     end
   end

   expect(current_path).to eql('/favorites')
 end
