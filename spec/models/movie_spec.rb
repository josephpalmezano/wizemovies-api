require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:reviews) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end
end
