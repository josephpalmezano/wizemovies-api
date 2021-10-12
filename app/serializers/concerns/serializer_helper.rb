module SerializerHelper
	extend ActiveSupport::Concern

	class_methods do
	  def ask_for_details?(params)
	    params && params[:details] == true
	  end
	end
end