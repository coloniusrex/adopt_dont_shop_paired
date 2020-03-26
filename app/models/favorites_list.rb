class FavoritesList
  def initialize(favorites_list = [])
    @pets = favorites_list
  end

  def pets
    @pets
  end

  def add_pet(pet_id)
    pets << pet_id unless pets.include?(pet_id)
  end
end
