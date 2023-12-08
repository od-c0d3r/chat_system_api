class Messages::UpdateChatMessagesCounterJob
  include Sidekiq::Job

  def perform(chat_id)
    chat = Chat.find chat_id
    lock_info = RedlockClient.lock("chat_lock:#{chat.id}", 5_000)

    return unless lock_info

    begin
      chat.update(messages_count: chat.messages_count + 1)
    ensure
      RedlockClient.unlock(lock_info)
    end
  end
end
