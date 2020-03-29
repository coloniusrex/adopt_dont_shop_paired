class Pet < ApplicationRecord
  validates_presence_of :image_url, :name, :description, :approximate_age,
                        :sex
  validates :adoptable, inclusion: { in: [true, false] }
  belongs_to :shelter

  has_many :pet_adoption_apps
  has_many :adoption_apps, through: :pet_adoption_apps

  def adoption_pending
    self.update(adoptable: false)
  end

  def add_applicant_name(name)
    self.update(applicant_name: name)
  end

end
