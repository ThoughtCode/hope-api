require 'rails_helper'

RSpec.describe Api::V1::Customers::CustomersController, type: :controller do
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
        password: '123456',
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        national_id: '123456',
        cell_phone: '123456',
        birthday: Faker::Date.birthday(18, 65)
      } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Customer have been'\
        ' updated successfully.')
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
        birthday: Faker::Date.birthday(18, 65)
      } }
      expect(response.status).to eq(422)
    end
    it 'return 404 with message if no user' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { customer: {
        access_token: 'asdasd',
        email: Faker::Internet.email
      } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to eq('message' => 'Customer not '\
        'found.')
    end
  end
end
