require 'rails_helper'

RSpec.describe Api::V1::Customers::ProvidersController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:customer]
  end

  describe 'POST #facebook' do
    it 'return 200 and register the user' do
      test_user = Koala::Facebook::TestUsers.new(
        app_id: Rails.application.secrets.facebook_api_id,
        secret: Rails.application.secrets.facebook_secret
      )
      post :facebook, params: { customer: {
        facebook_access_token: test_user.app_access_token
      } }
      expect(response.status).to eq(200)
    end
  end
end
