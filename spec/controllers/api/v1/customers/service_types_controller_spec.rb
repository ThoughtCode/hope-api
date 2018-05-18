require 'rails_helper'

RSpec.describe Api::V1::Customers::ServiceTypesController, type: :controller do
  include Serializable

  let(:customer) { FactoryBot.create(:customer) }
  let(:service_type) { FactoryBot.create(:service_type) }
  describe 'GET #index' do
    it 'return 200 with array of service types' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :index
      expect(JSON.parse(response.body)).to include(
        'message' => 'Service types successfully listed.'
      )
    end
  end
  describe 'GET #show' do
    it 'return 200 with service type' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: { id: service_type.hashed_id }
      expect(response.status).to eq(200)
    end

    it 'return 404 if not found' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: { id: service_type.id }
      expect(response.status).to eq(404)
    end
  end
end
