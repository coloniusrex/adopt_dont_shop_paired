require "rails_helper"

RSpec.describe FavoritesList, type: :model do
  describe "PORO" do
    it "Exists and has attributes" do
      list = FavoritesList.new

      expect(list.pets).to eql([])
    end

    it "can add many pet_ids to the list" do
      list = FavoritesList.new
      pet_id1 = 1
      pet_id2 = 2

      list.add_pet(pet_id1)
      list.add_pet(pet_id2)

      expect(list.pets).to eql([pet_id1, pet_id2])
    end

    it "can only add a pet_id once" do
      list = FavoritesList.new
      pet_id1 = 1
      pet_id2 = 2

      list.add_pet(pet_id1)
      list.add_pet(pet_id2)

      expect(list.pets).to eql([pet_id1, pet_id2])

      list.add_pet(pet_id1)

      expect(list.pets).to eql([pet_id1, pet_id2])
    end
  end
end
