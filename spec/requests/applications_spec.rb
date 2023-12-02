# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, type: :request do
  describe 'GET /api/v1/applications' do
    it 'returns Applications data' do
      FactoryBot.create_list(:application, 10)

      get '/api/v1/applications'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(10)
    end
  end

  describe 'GET /api/v1/applications/:token' do
    it 'returns Application data' do
      application = FactoryBot.create(:application)
      chats = FactoryBot.create_list(:chat, 5, application: application)

      get "/api/v1/applications/#{application.token}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(application.name)
      expect(JSON.parse(response.body)['chats_count']).to eq(chats.length)
    end
    it 'returns 404 if token not found' do
      get '/api/v1/applications/invalid'

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Application not found')
    end
  end

  describe 'POST /api/v1/applications' do
    it 'creates a new Application' do
      post '/api/v1/applications', params: { name: 'Test Application' }

      expect(response).to have_http_status(:success)
      expect(Application.count).to eq(1)
    end
    it 'returns the created Application token' do
      post '/api/v1/applications', params: { name: 'Test Application' }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['token']).to be_present
    end
  end

  describe 'PUT /api/v1/applications/:token' do
    it 'updates an Application' do
      application = FactoryBot.create(:application, name: 'Test Application')

      put "/api/v1/applications/#{application.token}", params: { name: 'Updated Application' }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq('Updated Application')
    end
  end

  describe 'DELETE /api/v1/applications/:token' do
    it 'deletes an Application' do
      application = FactoryBot.create(:application)

      delete "/api/v1/applications/#{application.token}"

      expect(response).to have_http_status(:success)
      expect(Application.count).to eq(0)
    end
    it 'reutrns 404 if token not found' do
      delete '/api/v1/applications/invalid'

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors']).to eq('Application not found')
    end
  end
end
