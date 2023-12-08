class Chats::UpdateAppChatsCounterJob
  include Sidekiq::Job

  def perform(token)
    application = Application.find_by_token token

    application.update(chats_count: application.chats_count + 1)
  end
end
