class MovieSerializer
  include JSONAPI::Serializer

  include SerializerHelper

  attributes :id, :title, :poster_url, :genres, :rating


  attributes :plot, if: Proc.new { |record, params|
    ask_for_details?(params)
  }

  attributes :genres, if: Proc.new { |record, params|
    ask_for_details?(params)
  } do |object|
    object.genres.map { |element| element.name }
  end
end
