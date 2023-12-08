# frozen_string_literal: true

puts 'Seeding...'

3.times do
  application = Application.create(
    name: Faker::Company.name
  )
  4.times do
    application.update(
      chats_count: application.chats_count + 1
    )

    chat = Chat.create(
      application: application
    )
    5.times do
      chat.update(
        messages_count: chat.messages_count + 1
      )

      Message.create(
        chat: chat,
        body: Faker::Lorem.sentence
      )
    end
  end
end

puts 'Seedding Done!'
