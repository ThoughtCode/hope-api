require 'rails_helper'

RSpec.describe Api::V1::Agents::AgentsController, type: :controller do
  include Serializable
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:agent]
  end
  let(:agent) { FactoryBot.create(:agent) }
  describe 'PUT #update' do
    it 'return 200 with message successfully' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      put :update, params: { agent: {
        access_token: agent.access_token,
        email: agent.email,
        password: '123456',
        first_name: agent.first_name,
        last_name: agent.last_name,
        national_id: '123456',
        cell_phone: '123456',
        birthday: agent.birthday
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Agent have been'\
        ' updated successfully.', 'agent' => serialize_agent(agent).as_json)
    end
    it 'return 422 if invalid params' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      put :update, params: { agent: {
        access_token: agent.access_token,
        email: '',
        password: '',
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        national_id: '123456',
        cell_phone: '123456',
        birthday: Faker::Date.birthday(18, 65)
      } }
      expect(response.status).to eq(422)
    end
    it 'return 404 with message if no user' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      put :update, params: { agent: {
        access_token: 'asdasd',
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq('message' => 'Agent not '\
        'found.', 'data' => [])
    end
  end
end
