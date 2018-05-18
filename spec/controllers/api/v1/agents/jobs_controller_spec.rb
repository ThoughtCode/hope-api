require 'rails_helper'

RSpec.describe Api::V1::Agents::JobsController, type: :controller do
  let(:agent) { FactoryBot.create(:agent) }
  let(:job) { FactoryBot.create(:job) }
  describe 'GET #index' do
    it 'return 200 with message' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      get :show, params: {
        id: job.hashed_id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Trabajo econtrado existosamente.'
      )
    end
    it 'return 404 with message' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      get :show, params: {
        id: job.id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El trabajo no existe'
      )
    end
  end
end
