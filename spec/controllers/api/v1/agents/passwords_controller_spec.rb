require 'rails_helper'

RSpec.describe Api::V1::Agents::PasswordsController, type: :controller do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @request.env['devise.mapping'] = Devise.mappings[:agent]
  end

  let(:agent) { FactoryBot.create(:agent) }
  describe 'POST #create' do
    it 'return 200 with message successfully' do
      post :create, params: { agent: {
        email: agent.email
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Reset '\
        'password instructions have been sent to email')
    end
    it 'return 404 with message if no user' do
      post :create, params: { agent: {
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Email does '\
        'not exist')
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
      expect(JSON.parse(response.body)).to include('message' => 'Reset '\
        'password successfully')
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

  describe 'POST #app_recover_password' do
    it 'return 200 with message successfully' do
      post :app_recover_password, params: { agent: {
        email: agent.email
      } }
      expect do
        AgentMailer.send_recover_password_app_email(agent).deliver
      end .to change(ActionMailer::Base.deliveries, :count).by 1
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Un pin ha '\
        'sido enviado al correo especificado')
    end
    it 'return 404 with message if no user' do
      post :app_recover_password, params: { agent: {
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El correo no existe'
      )
    end
  end

  describe 'POST #app_update_password' do
    it 'return 200 with message successfully' do
      agent.set_reset_password_pin!
      post :app_update_password, params: { agent: {
        mobile_token: agent.mobile_token,
        password: '123456',
        password_confirmation: '123456'
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Contraseña reseteada exitosamente'
      )
    end
    it 'return 404 with message if no user' do
      agent.set_reset_password_pin!
      post :app_update_password, params: { agent: {
        mobile_token: agent.mobile_token,
        password: '123456',
        password_confirmation: '1234'
      } }
      expect(response.status).to eq(404)
    end
  end
end
