class Api::V1::MoviesController < Api::V1::BaseController
	def index
    render json: Movie.all,
           status: :ok
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
