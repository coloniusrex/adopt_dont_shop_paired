class FavoritesList
  def initialize(favorites_list)
    @pets = favorites_list ||= []
  end

  def pets
    @pets
  end

  def add_pet(pet_id)
    return pets << pet_id unless pets.include?(pet_id)
    false
  end

  def pets_total
    pets.length
  end

  def valid?(pet_id)
    pets.include?(pet_id.to_s)
  end

  def remove_id(pet_id)
    pets.delete(pet_id)
  end
end
