require 'rails_helper'
RSpec.describe Api::V1::Customers::NeightborhoodsController do
  include Serializable
  let(:customer) { FactoryBot.create(:customer) }
  let(:city) { FactoryBot.create(:city) }
  describe 'GET #index' do
    it 'return 200 with array of cities' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :index, params: { city_id: city.id }
      expect(JSON.parse(response.body)).to include(
        'message' => 'Barrios listados exitosamente',
        'data' => serialize_neightborhood(Neightborhood.all).as_json
      )
    end
  end
end
