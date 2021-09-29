class Api::V1::BaseController < ActionController::Base
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
	rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

	private

	def record_not_found(exception)
	  render json: {error: exception.message}.to_json, status: :not_found
	end

	def record_invalid(exception)
	  render json: {error: exception.message}.to_json, status: :unprocessable_entity
	end
end