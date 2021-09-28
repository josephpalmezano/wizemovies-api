class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :plot
end
