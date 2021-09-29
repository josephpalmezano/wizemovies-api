class ReviewSerializer
  include JSONAPI::Serializer
  attributes :id, :content, :rating, :title, :user_name, :created_at, :movie_id
end
