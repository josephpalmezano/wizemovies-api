FactoryBot.define do
  factory :review do
    rating { rand(1..5) }
    user_name { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    title { Faker::Lorem.sentence }
    movie_id { create(:movie).id }
  end
end
