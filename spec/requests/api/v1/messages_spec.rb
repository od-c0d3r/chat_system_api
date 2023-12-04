# frozen_string_literal: true

describe Api::V1::MessagesController, type: :request do
  describe 'GET /api/v1/chats/:chat_number/messages' do
    it 'returns an chat messages' do
      chat = FactoryBot.create(:chat)
      FactoryBot.create_list(:message, 5, chat: chat)

      get "/api/v1/chats/#{chat.number}/messages"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

  describe 'GET /api/v1/chats/:chat_number/messages/:message_number' do
    it 'returns a message' do
      chat = FactoryBot.create(:chat)
      message = FactoryBot.create(:message, chat: chat)

      get "/api/v1/chats/#{chat.number}/messages/#{message.number}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['body']).to eq(message.body)
    end

    it 'returns 404 if chat_number not found' do
      get '/api/v1/chats/invalid/messages/1'

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end

    it 'returns 404 if message_number not found' do
      chat = FactoryBot.create(:chat)

      get "/api/v1/chats/#{chat.number}/messages/invalid"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Message not found')
    end
  end

  describe 'POST /api/v1/chats/:chat_number/messages' do
    it 'creates a new message' do
      chat = FactoryBot.create(:chat)

      post "/api/v1/chats/#{chat.number}/messages", params: { body: 'test' }

      expect(response).to have_http_status(:success)
      expect(chat.messages_count).to eq(1)
    end
    it 'returns 404 if chat_number not found' do
      post '/api/v1/chats/invalid/messages', params: { body: 'test' }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end
  end

  describe 'PATCH /api/v1/chats/:chat_number/messages/:message_number' do
    it 'updates a message' do
      chat = FactoryBot.create(:chat)
      message = FactoryBot.create(:message, chat: chat, body: 'test')

      put "/api/v1/chats/#{chat.number}/messages/#{message.number}", params: { body: 'test2' }

      expect(response).to have_http_status(:success)
      expect(message.reload.body).to eq('test2')
    end
    it 'returns 404 if chat_number not found' do
      put '/api/v1/chats/invalid/messages/1', params: { body: 'test' }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end
    it 'returns 404 if message_number not found' do
      chat = FactoryBot.create(:chat)

      put "/api/v1/chats/#{chat.number}/messages/invalid", params: { body: 'test' }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Message not found')
    end
  end
end
