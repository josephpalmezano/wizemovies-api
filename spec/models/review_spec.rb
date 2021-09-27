require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:movie) }
  end

  describe 'validations' do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { 
      should validate_numericality_of(:rating)
        .only_integer
        .is_less_than_or_equal_to(5)
        .is_greater_than_or_equal_to(1)
        .with_message('invalid') 
    }
  end
end
