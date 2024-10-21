FactoryBot.define do
  factory :comment do
    text { "This is a comment" }
    story
    id { rand(1000..9999) }
  end
end
