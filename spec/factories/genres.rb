FactoryBot.define do
  factory :genre do
    sequence(:the_movie_db_id)
    name { Faker::Book.genre }
  end
end
