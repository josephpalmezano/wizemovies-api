FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    plot { Faker::Movie.quote }
  end
end
