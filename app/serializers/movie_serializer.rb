require File.expand_path('helpers/serializer_helper', __dir__)

class MovieSerializer
  include JSONAPI::Serializer

  include SerializerHelper

  attributes :id, :title, :poster_url, :genres

  has_many :reviews

  attributes :plot, if: Proc.new { |record, params|
    ask_for_details?(params)
  }

  attributes :genres, if: Proc.new { |record, params|
    ask_for_details?(params)
  } do |object|
    object.genres.map { |element| element.name }
  end
end
