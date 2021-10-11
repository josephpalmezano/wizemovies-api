class Api::V1::MoviesController < Api::V1::BaseController
	def index
		pagy, records = pagy(Movie.select(:id, :title, :poster_url))
    render json: {
    								data: MovieSerializer.new(records), 
    								pagination: {page: pagy.page, next: pagy.next}, 
    								status: :ok
    							}
	end

  def show
		render json: {
										data: MovieSerializer.new(movie, params: {details: true}), 
										status: :ok
									}
  end

	private

	def movie
		Movie.find(params[:id])
	end
end