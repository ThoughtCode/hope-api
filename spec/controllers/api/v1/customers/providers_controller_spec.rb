require 'rails_helper'

RSpec.describe Api::V1::Customers::ProvidersController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:customer]
    @test_users = Koala::Facebook::TestUsers.new(
      app_id: Rails.application.secrets.facebook_api_id,
      secret: Rails.application.secrets.facebook_secret
    )
  end

  describe 'POST #facebook' do
    it 'return 200 and register the user' do
      user = @test_users.create(true, 'email')
      post :facebook, params: { customer: {
        facebook_access_token: user['access_token']
      } }
      expect(response.status).to eq(200)
    end
    it 'return 200 and login the user already register' do
      user = @test_users.create(true, 'email')
      post :facebook, params: { customer: {
        facebook_access_token: user['access_token']
      } }
      post :facebook, params: { customer: {
        facebook_access_token: user['access_token']
      } }
      expect(response.status).to eq(200)
    end
    it 'return 422 unprocesable entity' do
      user = @test_users.create(true)
      post :facebook, params: { customer: {
        facebook_access_token: user['access_token']
      } }
      expect(response.status).to eq(422)
    end
    it 'return 404 if token is missing' do
      post :facebook
      expect(response.status).to eq(400)
    end
  end
end
