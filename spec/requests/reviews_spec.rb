require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let!(:movie_with_reviews) { create(:movie_with_reviews, reviews: 5) }
  let!(:movie_without_reviews) { create(:movie) }

  describe 'REST Api' do
    describe 'GET /movie_reviews/:movie_id' do 
      it 'returns 404 when movie doesn not exists' do
        get "/api/v1/reviews/movie_reviews/0"
        expect(response).to have_http_status(:not_found)       
      end

      it 'returns 0 reviews' do
        get "/api/v1/reviews/movie_reviews/#{movie_without_reviews.id}"
        expect(json.size).to eq(0)       
      end

      before { get "/api/v1/reviews/movie_reviews/#{movie_with_reviews.id}" }

      it 'returns all reviews' do
        expect(json).not_to be_empty        
      end

      it 'returns 5 reviews' do
        expect(json.size).to eq(5)       
      end

      it 'returns only reviews form passed :movie_id' do
        expect(json.map { |element| element["movie_id"] }.uniq.size).to eq(1)
        expect(json.map { |element| element["movie_id"] }.uniq.first).to eq(movie_with_reviews.id)
      end

      it 'returns the reviews ordered by :created_at' do
        expect(Review.all.to_sql).to eq(Review.order(created_at: :asc).to_sql)        
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)    
      end
    end
  end
end
