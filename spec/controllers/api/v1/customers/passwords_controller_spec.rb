require 'rails_helper'

RSpec.describe Api::V1::Customers::PasswordsController, type: :controller do
  let(:customer) { FactoryBot.create(:customer) }
  describe 'POST #create' do
    it 'return 200 with message successfully' do
      customer.save!
      post :create, params: { customer: {
        email: customer.email
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Reset password '\
        'instructions have been sent to email')
    end
    it 'return 404 with message if no user' do
    end
  end

  describe 'PUT #update' do
    it 'return 200 with message successfully' do
    end
    it 'return 404 with errors' do
    end
  end
end
