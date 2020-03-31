class Pet < ApplicationRecord
  validates_presence_of :image_url, :name, :description, :approximate_age,
                        :sex
  validates :adoptable, inclusion: { in: [true, false] }
  belongs_to :shelter

  has_many :pet_adoption_apps
  has_many :adoption_apps, through: :pet_adoption_apps

  def make_unadoptable
    self.update(adoptable: false)
  end

  def make_adoptable
    self.update(adoptable: true)
  end

  def has_approved_application?
    !pet_adoption_apps.where(approved: true).empty?
  end

  def approved_application_id
    if has_approved_application?
      pet_adoption_apps.where(approved: true).take.adoption_app_id
    else
      0
    end
  end

  def approved_applicant_name
    adoption_apps.find(approved_application_id).name
  end

  def self.make_unadoptable(array_of_pet_ids)
    
  end

end
