FactoryBot.define do
  factory :video do
    profile { nil }
    lesson { nil }
    voice_sample { nil }
    status { "MyString" }
    video_url { "MyString" }
  end
end
