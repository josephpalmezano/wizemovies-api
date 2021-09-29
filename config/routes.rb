Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show]
      resources :reviews, only: %i[destroy update create] do
        get 'movie_reviews/:movie_id/', to: 'reviews#movie_reviews', on: :collection, as: :movie_reviews
      end
    end
  end
end

# == Route Map
#
