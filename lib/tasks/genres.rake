require 'net/http'

namespace :genres do
  desc "create genres"
  task create: :environment do
    uri = URI("https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['the_movie_db_api_key']}&language=en-US")
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
      JSON.parse(response.body)["genres"].each do |genre|
        Genre.create!(name: genre["name"], the_movie_db_id: genre["id"])
      end
    end
  end
end