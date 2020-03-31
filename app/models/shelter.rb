class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews

  def adoptable_pets
    pets.where(adoptable:true)
  end

  def pets_pending_adoption?
    pets.where(adoptable:false).present?
  end

  def destroy_dependencies
    pets.each do |pet|
      pet.pet_adoption_apps.destroy_all
    end
    pets.destroy_all
    reviews.destroy_all
  end

  def pet_count
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def total_applications
    apps = []
    pets.each do |pet|
      apps << pet.adoption_apps
    end
    apps.flatten.uniq.length
  end
end
