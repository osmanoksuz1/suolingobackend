FactoryBot.define do
  factory :lesson do
    profile { nil }
    lesson_text { "MyText" }
    difficulty_level { "MyString" }
  end
end
