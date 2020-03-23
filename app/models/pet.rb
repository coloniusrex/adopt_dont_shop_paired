class Pet < ApplicationRecord
  validates_presence_of :image_url, :name, :description, :approximate_age,
                        :sex
  validates :adoptable, inclusion: { in: [true, false] }
  belongs_to :shelter

  def adoption_status
    if adoptable
      "adoptable"
    else
      "pending adoption"
    end
  end
end
