# frozen_string_literal: true

puts 'Seeding...'

3.times do
  application = Application.create(
    name: Faker::Company.name
  )
  4.times do
    chat = Chat.create(
      application: application
    )
    5.times do
      Message.create(
        chat: chat,
        body: Faker::Lorem.sentence
      )
    end
  end
end

puts 'Seedding Done!'
