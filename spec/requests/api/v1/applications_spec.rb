# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, type: :request do
  describe 'GET /api/v1/applications' do
    it 'returns Applications data' do
      FactoryBot.create_list(:application, 10)

      get '/api/v1/applications'

      expect(response).to have_http_status(:success)
      expect(data_of(response.body).length).to eq(10)
    end
  end

  describe 'GET /api/v1/applications/:token' do
    it 'returns requested Application data' do
      application = FactoryBot.create(:application)

      get "/api/v1/applications/#{application.token}"

      expect(response).to have_http_status(:success)
      expect(data_of(response.body)['name']).to eq(application.name)
    end

    it 'returns 404 if token not found' do
      get '/api/v1/applications/invalid'

      expect(response).to have_http_status(:not_found)
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
      expect(data_of(response.body)['token']).to be_present
    end
  end

  describe 'PATCH /api/v1/applications/:token' do
    it 'updates an Application' do
      application = FactoryBot.create(:application, name: 'Test Application')

      put "/api/v1/applications/#{application.token}", params: { name: 'Updated Application' }

      expect(response).to have_http_status(:success)
      expect(data_of(response.body)['name']).to eq('Updated Application')
    end
  end

  describe 'it dose not return application id in response' do
    it 'does not return application id in response' do
      FactoryBot.create(:application)

      get '/api/v1/applications'

      expect(response).to have_http_status(:success)
      expect(data_of(response.body)[0]['id']).to be_nil
      expect(data_of(response.body)[0]['token']).to be_present
      expect(data_of(response.body)[0]['name']).to be_present
    end
  end
end
