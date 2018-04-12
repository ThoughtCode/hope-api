require 'rails_helper'

RSpec.describe Api::V1::Customers::ServiceTypesController, type: :controller do
  include Serializable

  let(:customer) { FactoryBot.create(:customer) }
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
end
