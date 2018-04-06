require 'rails_helper'

RSpec.describe Api::V1::Customers::PasswordsController, type: :controller do
  before(:each) do
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
end
