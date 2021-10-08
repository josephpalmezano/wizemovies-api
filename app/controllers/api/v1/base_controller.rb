class Api::V1::BaseController < ActionController::Base
	include Pagy::Backend
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
	rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
	rescue_from Pagy::OverflowError, with: :page_not_found
	rescue_from Pagy::VariableError, with: :page_not_found

	private

	def record_not_found(exception)
	  render json: {error: exception.message}.to_json, status: :not_found
	end

	def record_invalid(exception)
	  render json: {error: exception.message}.to_json, status: :unprocessable_entity
	end

	def page_not_found(exception)
	  render json: {error: exception.message}.to_json, status: :not_found
	end
end