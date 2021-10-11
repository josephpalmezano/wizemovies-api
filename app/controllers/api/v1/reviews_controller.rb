class Api::V1::ReviewsController < Api::V1::BaseController
	before_action :set_movie, only: :movie_reviews
	before_action :set_review, only: %i[update destroy]

	def movie_reviews
    render {json: @movie.reviews,
           status: :ok
	end

	def create
    review = Review.new(review_params)
    review.save!
    render json: review, 
    			 status: :created
	end

	def update
    @review.update!(review_params)
    render json: @review, 
    			status: :ok
	end

	def destroy
    @review.destroy
    head :no_content
	end

	private

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end

	def set_review
		@review = Review.find(params[:id])
	end

  def review_params
    params.permit(:content, :rating, :title, :user_name, :movie_id)
  end
end