require 'rails_helper'

RSpec.describe "Movies", type: :request do
  let!(:movies) { create_list(:movie, 5) }

  describe 'REST Api' do
    describe 'GET /movies' do
      before { get '/api/v1/movies' }

      it 'returns all movies' do
        expect(json).not_to be_empty        
      end

      it 'returns 5 movies' do
        expect(json.size).to eq(5)       
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)    
      end
    end

    describe 'GET /movies/:id' do
      it 'returns 404 when movie doesn not exists' do
        get "/api/v1/movies/0"
        expect(response).to have_http_status(:not_found)       
      end

      let!(:movie_id) { movies.first.id }
      
      before { get "/api/v1/movies/#{movie_id}" }

      it 'returns the movie item' do
        expect(json["id"]).to eq(movie_id)        
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)     
      end
    end
  end
end
