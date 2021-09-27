FactoryBot.define do
  factory :review do
    rating { 1 }
    user_name { "MyString" }
    content { "MyText" }
    title { "MyString" }
    movie
  end
end
