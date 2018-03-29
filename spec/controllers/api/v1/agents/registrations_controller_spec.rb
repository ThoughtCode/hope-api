require 'rails_helper'

RSpec.describe Api::V1::Agents::RegistrationsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:agent]
  end
  let(:valid_params) do
    { 'agent' => {
      'first_name' => Faker::Name.first_name,
      'last_name' => Faker::Name.last_name,
      'email' => Faker::Internet.email,
      'password' => 'test1234',
      'password_confirmation' => 'test1234',
      'national_id' => '123456',
      'cell_phone' => '1234567',
      'birthday' => Faker::Date.birthday(18, 65)
    } }
  end
  let(:invalid_params) do
    { 'agent' => {
      'first_name' => Faker::Name.first_name,
      'last_name' => Faker::Name.last_name,
      'email' => Faker::Internet.email,
      'password' => 'test1',
      'password_confirmation' => 'test1234'
    } }
  end
  let(:not_ensure_params) do
    {
      'first_name' => Faker::Name.first_name,
      'last_name' => Faker::Name.last_name,
      'email' => Faker::Internet.email,
      'password' => 'test1',
      'password_confirmation' => 'test1234'
    }
  end
  describe 'POST #create' do
    it 'return 200 with valid params and create agent' do
      post :create, params: valid_params
      expect(response.status).to eq(200)
    end

    it 'return 422 with invalid params' do
      post :create, params: invalid_params
      expect(response.status).to eq(422)
    end

    it 'return 422 with no ensure params' do
      post :create, params: not_ensure_params
      expect(response.status).to eq(422)
    end
  end
end
