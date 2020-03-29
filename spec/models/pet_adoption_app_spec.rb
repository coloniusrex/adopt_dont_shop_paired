require "rails_helper"

RSpec.describe PetAdoptionApp, type: :model do

  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :adoption_app}
  end
end
