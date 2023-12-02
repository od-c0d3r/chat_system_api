# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ChatsController, type: :request do
  describe 'GET /api/v1/applications/:token/chats' do
    it 'returns an Application chats' do
      application = FactoryBot.create(:application)
      chats = FactoryBot.create_list(:chat, 5, application: application)

      get "/api/v1/applications/#{application.token}/chats"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(chats.length)
    end

    it 'returns 404 if token not found' do
      get '/api/v1/applications/invalid/chats'

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /api/v1/applications/:token/chats/:chat_number' do
    it 'returns Chat data' do
      application = FactoryBot.create(:application)
      chat = FactoryBot.create(:chat, application: application)
      FactoryBot.create_list(:message, 5, chat: chat)

      get "/api/v1/applications/#{application.token}/chats/#{chat.number}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['messages_count']).to eq(5)
    end

    it 'returns 404 if token not found' do
      chat = FactoryBot.create(:chat)

      get "/api/v1/applications/invalid/chats/#{chat.number}"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Application not found')
    end

    it 'returns 404 if chat_number not found' do
      application = FactoryBot.create(:application)

      get "/api/v1/applications/#{application.token}/chats/invalid"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Chat not found')
    end
  end

  describe 'POST /api/v1/applications/:token/chats' do
    it 'creates a new Chat' do
      application = FactoryBot.create(:application)

      post "/api/v1/applications/#{application.token}/chats"

      expect(response).to have_http_status(:success)
      expect(Chat.count).to eq(1)
    end

    it 'returns the created Chat number' do
      application = FactoryBot.create(:application)

      post "/api/v1/applications/#{application.token}/chats"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['chat_number']).to be_present
    end

    it 'returns 404 if token not found' do
      post '/api/v1/applications/invalid/chats'

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Application not found')
    end
  end

  describe 'PUT /api/v1/applications/:token/chats/:chat_number' do
    it 'updates a Chat' do
      application = FactoryBot.create(:application)
      application2 = FactoryBot.create(:application)
      chat = FactoryBot.create(:chat, application: application)

      put "/api/v1/applications/#{application.token}/chats/#{chat.number}", params: { application_id: application2.id }

      expect(response).to have_http_status(:success)
      expect(chat.reload.application_id).to eq(application2.id)
    end
  end
end
