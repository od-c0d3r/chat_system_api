# frozen_string_literal: true
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe Chats::UpdateAppChatsCounterJob, type: :job do
  describe 'test' do
    pending 'test' do
      application = create(:application, chats_count: 0)
      chat = create(:chat, application: application)

      Chats::UpdateAppChatsCounterJob.perform_async application.token

      expect(chat.messages_count).to eq(1)
    end
  end
end
