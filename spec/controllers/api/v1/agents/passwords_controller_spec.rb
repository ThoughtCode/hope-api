require 'rails_helper'

RSpec.describe Api::V1::Agents::PasswordsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:agent]
  end
  let(:agent) { FactoryBot.create(:agent) }
  describe 'POST #create' do
    it 'return 200 with message successfully' do
      post :create, params: { agent: {
        email: agent.email
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Reset password '\
        'instructions have been sent to email')
    end
    it 'return 404 with message if no user' do
      post :create, params: { agent: {
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq('message' => 'Email does not '\
        'exist')
    end
  end

  describe 'POST #update' do
    it 'return 200 with message successfully' do
      token = agent.send_reset_password_instructions
      post :update, params: {
        reset_password_token: token,
        password: '123456',
        password_confirmation: '123456'
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Reset password '\
        'successfully')
    end
    it 'return 404 with errors' do
      post :update, params: {
        reset_password_token: 't3s7',
        password: '123456',
        password_confirmation: '123456'
      }
      expect(response.status).to eq(404)
    end
  end
end
