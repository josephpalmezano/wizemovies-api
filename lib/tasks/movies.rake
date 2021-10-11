require "http"

namespace :movies do
  desc "create movies"
  task create: :environment do
    (1..ENV["the_movie_db_max_page"].to_i).each do |page|
      response = HTTP.get("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['the_movie_db_api_key']}&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false&page=#{page}&vote_count.gte=1000&vote_average.gte=7&with_original_language=en&with_watch_monetization_types=flatrate")
      break if response.to_s.include?("\"results\":[]")
      if response.status.success?
        JSON.parse(response.body)["results"].each do |movie|
          new_movie = Movie.create!(title: movie["original_title"], plot: movie["overview"], poster_url: movie["poster_path"])
          movie["genre_ids"].each do |genre_id|
            new_movie.genres << Genre.find_by!(the_movie_db_id: genre_id)
            new_movie.save!
          end
        end
      end
    end
  end
end

