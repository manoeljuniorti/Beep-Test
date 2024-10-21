FactoryBot.define do
  factory :story do
    title { "Example Story" }
    url { "https://example.com/story" }
    id { rand(1000..9999) }
  end
end
