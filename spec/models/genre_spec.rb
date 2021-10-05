require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject(:genre) { FactoryBot.create(:genre) }

  describe 'associations' do
    it { should have_and_belong_to_many(:movies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:the_movie_db_id) }
    it { should validate_uniqueness_of(:the_movie_db_id) }
    it { 
      should validate_numericality_of(:the_movie_db_id)
        .only_integer
        .with_message('invalid') 
    }
  end
end
