require 'rails_helper'

RSpec.describe Api::V1::Customers::PasswordsController, type: :controller do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @request.env['devise.mapping'] = Devise.mappings[:customer]
  end
  let(:customer) { FactoryBot.create(:customer) }
  describe 'POST #create' do
    it 'return 200 with message successfully' do
      post :create, params: { customer: {
        email: customer.email
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Reset password instructions have been sent to email'
      )
    end
    it 'return 404 with message if no user' do
      post :create, params: { customer: {
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Email does not exist'
      )
    end
  end

  describe 'POST #update' do
    it 'return 200 with message successfully' do
      token = customer.send_reset_password_instructions
      post :update, params: {
        reset_password_token: token,
        password: '123456',
        password_confirmation: '123456'
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Reset password successfully'
      )
    end
    it 'return 422 if token dont match' do
      post :update, params: {
        reset_password_token: 't3s7',
        password: '123456',
        password_confirmation: '123456'
      }
      expect(response.status).to eq(422)
    end
  end
  describe 'POST #app_recover_password' do
    it 'return 200 with message successfully' do
      post :app_recover_password, params: { customer: {
        email: customer.email
      } }
      expect do
        CustomerMailer
          .send_recover_password_app_email(customer)
          .deliver
      end .to change(ActionMailer::Base.deliveries, :count).by 1
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Un pin ha '\
        'sido enviado al correo especificado')
    end
    it 'return 404 with message if no user' do
      post :app_recover_password, params: { customer: {
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
      customer.set_reset_password_pin!
      post :app_update_password, params: { customer: {
        email: customer.email,
        mobile_token: customer.mobile_token,
        password: '123456',
        password_confirmation: '123456'
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Contraseña reseteada exitosamente'
      )
    end
    it 'return 404 with message if no user' do
      customer.set_reset_password_pin!
      post :app_update_password, params: { customer: {
        email: Faker::Internet.email,
        mobile_token: customer.mobile_token,
        password: '123456',
        password_confirmation: '1234'
      } }
      expect(response.status).to eq(404)
    end
    it 'return 401 with message if pin expired' do
      customer.set_reset_password_pin!
      allow(DateTime).to receive(:current)
        .and_return(DateTime.current + 7.hours)
      post :app_update_password, params: { customer: {
        email: customer.email,
        mobile_token: customer.mobile_token,
        password: '123456',
        password_confirmation: '123456'
      } }
      expect(response.status).to eq(401)
    end
  end
end
