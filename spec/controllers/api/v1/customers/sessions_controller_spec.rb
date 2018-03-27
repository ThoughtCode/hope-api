require 'rails_helper'

RSpec.describe Api::V1::Customers::SessionsController, type: :controller do
  let(:customer) { FactoryBot.create(:customer) }
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
  describe 'POST #create' do
    it 'return customer with access_token' do
      post :create, params: { customer: {
        email: customer.email,
        password: customer.password
      } }
      expect(response.status).to eq(200)
    end

    it 'return 401 unauthorized if incorrect credentials' do
      post :create, params: { customer: {
        email: customer.email,
        password: '123456'
      } }
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE #destroy' do
    it 'return 200 logout the customer' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      delete :destroy
      expect(response.status).to eq(200)
    end

    it 'return 401 if token does not exists' do
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      delete :destroy
      expect(response.status).to eq(401)
    end
  end
end
