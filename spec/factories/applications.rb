FactoryBot.define do
  factory :application do
    token { SecureRandom.hex }
    name { Faker::App.name }
    chats_count { 0 }
  end
end
