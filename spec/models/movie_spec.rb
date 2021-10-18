require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:movie_with_reviews) { create(:movie_with_reviews, reviews: 10) }

  describe 'associations' do
    it { should have_many(:reviews) }
    it { should have_and_belong_to_many(:genres) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'rating' do
    it 'calculate rating' do
      expect(movie_with_reviews.rating).to eq(((movie_with_reviews.reviews.pluck(:rating).reduce(:+).to_f)/movie_with_reviews.reviews.size.to_f).ceil(1))
    end
  end
end
