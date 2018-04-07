require 'rails_helper'

RSpec.describe Api::V1::Customers::ServicesController, type: :controller do
  include Serializable

  let(:customer) { FactoryBot.create(:customer) }
  let(:service) { FactoryBot.create(:service) }
  describe 'GET #index' do
    it 'return 200 with array of service types' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :index, params: { service_type_id: service.service_type_id }
      expect(JSON.parse(response.body)).to include(
        'message' => 'Services successfully listed.'
      )
    end
  end
end
