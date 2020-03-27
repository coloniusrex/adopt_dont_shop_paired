require "rails_helper"

RSpec.describe FavoritesList, type: :model do
  describe "PORO" do
    it "Exists and has attributes" do
      list = FavoritesList.new(nil)

      expect(list.pets).to eql([])
    end

    it "can add many pet_ids to the list" do
      list = FavoritesList.new(nil)
      pet_id1 = 1
      pet_id2 = 2

      list.add_pet(pet_id1)
      list.add_pet(pet_id2)

      expect(list.pets).to eql([pet_id1, pet_id2])
    end

    it "can only add a pet_id once" do
      list = FavoritesList.new(nil)
      pet_id1 = 1
      pet_id2 = 2

      list.add_pet(pet_id1)
      list.add_pet(pet_id2)

      expect(list.pets).to eql([pet_id1, pet_id2])

      list.add_pet(pet_id1)

      expect(list.pets).to eql([pet_id1, pet_id2])
    end

    it "can supply count of favorite pets" do
      list = FavoritesList.new(nil)
      pet_id1 = 1
      pet_id2 = 2
      pet_id3 = 3

      expect(list.pets_total).to eql(0)

      list.add_pet(pet_id1)

      expect(list.pets_total).to eql(1)

      list.add_pet(pet_id2)

      expect(list.pets_total).to eql(2)

      list.add_pet(pet_id3)

      expect(list.pets_total).to eql(3)
    end

    it "can pass an array argument to initialize" do
      list = FavoritesList.new([1,2,3])

      expect(list.pets).to eql([1,2,3])

    end
  end
end
