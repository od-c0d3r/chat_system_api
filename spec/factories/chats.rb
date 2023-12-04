FactoryBot.define do
  factory :chat do
    application { FactoryBot.create(:application) }
    number { nil }
    messages_count { 0 }
  end
end
