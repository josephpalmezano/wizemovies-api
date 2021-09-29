class Api::V1::ReviewsController < Api::V1::BaseController
	def movie_reviews
    render json: movie.reviews,
           status: :ok
	end

	def create
	end

	def update
	end

	def destroy
	end

	private

	def movie
		Movie.find(params[:movie_id])
	end
end
