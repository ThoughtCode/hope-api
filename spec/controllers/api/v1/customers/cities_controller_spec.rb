require 'rails_helper'

RSpec.describe Api::V1::Customers::CitiesController, type: :controller do
  include Serializable
  let(:customer) { FactoryBot.create(:customer) }
  let(:city) { FactoryBot.create(:city) }
  describe 'GET #index' do
    it 'return 200 with array of cities' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :index
      expect(JSON.parse(response.body)).to include(
        'message' => 'Ciudades listadas exitosamente',
        'data' => serialize_city(City.all).as_json
      )
    end
  end
end
