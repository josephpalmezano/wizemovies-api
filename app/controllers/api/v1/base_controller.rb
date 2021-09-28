class Api::V1::BaseController < ActionController::Base
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	private

	def record_not_found(exception)
	  render json: {error: exception.message}.to_json, status: :not_found
	end
end