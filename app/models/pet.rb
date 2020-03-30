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

  def add_applicant_info(name, id)
    self.update(applicant_name: name, applicant_id: id)
  end

  def delete_applicant_info
    self.update(applicant_name: nil, applicant_id: nil)
  end


end
