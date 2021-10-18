require 'rails_helper'

RSpec.describe "Movies", type: :request do
  let!(:items_per_page) { 20 }
  let!(:movies) { create_list(:movie, 110) }
  let!(:pages)  { (movies.size.to_f/Float(items_per_page)).ceil }

  describe 'REST Api' do
    describe 'GET /movies' do
      it 'returns 404 when page doesn not exists' do
        get "/api/v1/movies?page=0"
        expect(response).to have_http_status(:not_found)       
      end

      it 'returns 404 when page doesn not exists' do
        get "/api/v1/movies?page=#{pages+1}"
        expect(response).to have_http_status(:not_found)       
      end

      before { get "/api/v1/movies?page=#{rand(1..(pages-1))}" }

      it 'returns all movies' do
        expect(json["data"]["data"]).not_to be_empty        
      end

      it 'returns 20 movies' do
        expect(json["data"]["data"].size).to eq(items_per_page) 
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
        expect(json["data"]["data"]["id"].to_i).to eq(movie_id)        
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)     
      end

      it "JSON body response contains expected movie attributes" do
        expect(json["data"]["data"]["attributes"].keys).to match_array(%w[id rating title poster_url genres plot])
      end
    end
  end
end
