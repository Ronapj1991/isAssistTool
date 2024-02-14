FactoryBot.define do
  factory :comment do |f|
    association :reported_incident
    content { Faker::Lorem.word }
  end
end
