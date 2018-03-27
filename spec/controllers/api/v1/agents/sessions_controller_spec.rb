require 'rails_helper'

RSpec.describe Api::V1::Agents::SessionsController, type: :controller do
  let(:agent) { FactoryBot.create(:agent) }
  describe 'POST #create' do
    it 'return agent with access_token' do
      post :create, params: { agent: {
        email: agent.email,
        password: agent.password
      } }
      expect(response.status).to eq(200)
    end

    it 'return 401 unauthorized if incorrect credentials' do
      post :create, params: { agent: {
        email: agent.email,
        password: '123456'
      } }
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE #destroy' do
    it 'return 200 logout the agent' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      delete :destroy
      expect(response.status).to eq(200)
    end

    it 'return 401 if token does not exists' do
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      delete :destroy
      expect(response.status).to eq(401)
    end
  end
end
