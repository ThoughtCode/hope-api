require 'rails_helper'

RSpec.describe Api::V1::Customers::CustomersController, type: :controller do
  include Serializable
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:customer]
  end
  let(:customer) { FactoryBot.create(:customer) }
  describe 'PUT #update' do
    it 'return 200 with message successfully' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { customer: {
        access_token: customer.access_token,
        email: customer.email,
        password: customer.password,
        first_name: customer.first_name,
        last_name: customer.last_name,
        national_id: customer.national_id,
        cell_phone: customer.cell_phone,
        birthday: customer.birthday,
        file: Rack::Test::UploadedFile.new(
          Rails.root.join('spec', 'support', 'image', 'test.jpg'), 'image/jpeg'
        )
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(
        'message' => 'Customer have been updated successfully.',
        'customer' => serialize_customer(customer).as_json
      )
    end
    it 'return 422 if invalid params' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { customer: {
        access_token: customer.access_token,
        email: '',
        password: '',
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        national_id: '123456',
        cell_phone: '123456',
        birthday: Faker::Date.birthday(18, 65),
        file: Rack::Test::UploadedFile.new(
          Rails.root.join('spec', 'support', 'image', 'test.jpg'), 'image/jpeg'
        )
      } }
      expect(response.status).to eq(422)
    end
    it 'return 404 with message if no user' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = 'Token asdasd'
      put :update, params: { customer: {
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)).to include(
        'message' => 'HTTP Token: Access denied.'
      )
    end
  end
end
