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
        expect(json["data"]["data"].size).to eq(0)       
      end

      before { get "/api/v1/reviews/movie_reviews/#{movie_with_reviews.id}" }

      it 'returns all reviews' do
        expect(json["data"]["data"]).not_to be_empty        
      end

      it 'returns 5 reviews' do
        expect(json["data"]["data"].size).to eq(5)       
      end

      it "JSON body response contains expected movie attributes" do
        expect(json["data"]["data"].first["attributes"].keys).to match_array(%w[id content rating title user_name created_at movie_id])
      end

      it 'returns only reviews form passed :movie_id' do
        expect(json["data"]["data"].map { |element| element["attributes"]["movie_id"] }.uniq.size).to eq(1)
        expect(json["data"]["data"].map { |element| element["attributes"]["movie_id"] }.uniq.first).to eq(movie_with_reviews.id)
      end

      it 'returns the reviews ordered by :created_at' do
        expect(Review.all.to_sql).to eq(Review.order(created_at: :asc).to_sql)        
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)    
      end
    end

    describe 'POST /api/v1/reviews' do
      it 'returns 422 when invalid attributes' do
        params_with_nil_content = [
          attributes_for(:review, content: nil),
          attributes_for(:review, title: nil),
          attributes_for(:review, rating: nil),
          attributes_for(:review, rating: "not integer"),
          attributes_for(:review, rating: 6),
          attributes_for(:review, rating: 0),
          attributes_for(:review, movie_id: 0)
        ]
        params_with_nil_content.each do |params|
          post "/api/v1/reviews", params: params
          expect(response).to have_http_status(:unprocessable_entity)  
        end
      end
      
      let!(:review) { attributes_for(:review) }

      before { post "/api/v1/reviews", params: review }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)    
      end

      it 'returns the created review' do
        expect(json["title"]).to eq(review[:title])
        expect(json["content"]).to eq(review[:content])
        expect(json["rating"]).to eq(review[:rating])
        expect(json["user_name"]).to eq(review[:user_name])
        expect(json["movie_id"]).to eq(review[:movie_id]) 
      end
    end
  end
end
