FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    number { nil }
    chat { nil }
  end
end
