class Chats::UpdateAppChatsCounterJob
  include Sidekiq::Job

  def perform(token)
    application = Application.find_by_token token
    lock_info = RedlockClient.lock("app_lock:#{application.token}", 5_000)

    return unless lock_info

    begin
      application.update(chats_count: application.chats_count + 1)
    ensure
      RedlockClient.unlock(lock_info)
    end
  end
end
