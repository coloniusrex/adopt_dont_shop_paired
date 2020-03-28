class Pet < ApplicationRecord
  validates_presence_of :image_url, :name, :description, :approximate_age,
                        :sex
  validates :adoptable, inclusion: { in: [true, false] }
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def adoption_status
    if adoptable
      "adoptable"
    else
      "pending adoption"
    end
  end
end
