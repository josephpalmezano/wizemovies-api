class Api::V1::MoviesController < Api::V1::BaseController
	def index
		pagy, records = pagy(Movie.all)
		render json: { data: records,
									 pagy: pagy,
               		 status: :ok
               	}
	end

  def show
    render json: movie,
           status: :ok
  end

	private

	def movie
		Movie.find(params[:id])
	end
end
