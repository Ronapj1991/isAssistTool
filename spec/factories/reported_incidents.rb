require 'faker'

FactoryBot.define do
  factory :reported_incident do |f|
    f.reported { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    f.sender { Faker::Internet.email }
    f.subject { Faker::Dessert.flavor }
    f.reported_by { Faker::Name.name }
    f.resolution { "Spam" }
    f.themis_confidence { 90 }
    f.resolved_by { "Themis" }
    f.incident_id { 34394863 }
  end
end