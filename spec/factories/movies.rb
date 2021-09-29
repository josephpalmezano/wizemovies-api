FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    plot { Faker::Movie.quote }

    factory :movie_with_reviews do
      transient do
        reviews { 5 }
      end

      after(:create) do |movie, evaluator|
        FactoryBot.create_list(:review,
                               evaluator.reviews,
                               movie: movie)
      end
    end
  end
end
