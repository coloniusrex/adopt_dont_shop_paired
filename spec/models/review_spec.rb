require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :content}
    # Figure out optional tests, if needed
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end
end
