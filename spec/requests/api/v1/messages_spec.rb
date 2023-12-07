# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do
  let(:chat) { FactoryBot.create(:chat) }

  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages' do
    it 'returns an chat messages' do
      token = chat.application.token
      FactoryBot.create_list(:message, 5, chat: chat)

      get "/api/v1/applications/#{token}/chats/#{chat.number}/messages",
          params: { chat_number: chat.number, application_token: chat.application.token }

      expect(response).to have_http_status(:success)
      expect(data_of(response.body).length).to eq(5)
    end
  end

  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages/:message_number' do
    it 'returns a Message' do
      token = chat.application.token
      message = FactoryBot.create(:message, chat: chat)

      get "/api/v1/applications/#{token}/chats/#{chat.number}/messages/#{message.number}"

      expect(response).to have_http_status(:success)
      expect(data_of(response.body)['body']).to eq(message.body)
    end

    it 'returns 404 if chat_number not found' do
      token = chat.application.token

      get "/api/v1/applications/#{token}/chats/invalid/messages/1"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end

    it 'returns 404 if message_number not found' do
      token = chat.application.token

      get "/api/v1/applications/#{token}/chats/#{chat.number}/messages/invalid"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Message not found')
    end
  end

  describe 'POST /api/v1/applications/:application_token/chats/:chat_number/messages' do
    it 'creates a new message' do
      token = chat.application.token

      post "/api/v1/applications/#{token}/chats/#{chat.number}/messages", params: { message: { body: 'test' } }

      expect(response).to have_http_status(:success)
      expect(chat.messages.count).to eq(1)
    end
    it 'returns 404 if chat_number not found' do
      token = chat.application.token

      post "/api/v1/applications/#{token}/chats/invalid/messages", params: { message: { body: 'test' } }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end
  end

  describe 'PATCH /api/v1/applications/:application_token/chats/:chat_number/messages/:message_number' do
    it 'updates a message' do
      token = chat.application.token
      message = FactoryBot.create(:message, chat: chat, body: 'test')

      put "/api/v1/applications/#{token}/chats/#{chat.number}/messages/#{message.number}",
          params: { message: { body: 'test2' } }

      expect(response).to have_http_status(:success)
      expect(message.reload.body).to eq('test2')
    end
    it 'returns 404 if chat_number not found' do
      token = chat.application.token

      put "/api/v1/applications/#{token}/chats/invalid/messages/1", params: { message: { body: 'test' } }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end
    it 'returns 404 if message_number not found' do
      token = chat.application.token

      put "/api/v1/applications/#{token}/chats/#{chat.number}/messages/invalid", params: { message: { body: 'test' } }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Message not found')
    end
  end
end
