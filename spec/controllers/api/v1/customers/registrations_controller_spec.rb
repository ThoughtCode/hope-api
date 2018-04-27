require 'rails_helper'

RSpec.describe Api::V1::Customers::RegistrationsController, type: :controller do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @request.env['devise.mapping'] = Devise.mappings[:customer]
  end
  let(:valid_params) do
    { 'customer' => {
      'first_name' => Faker::Name.first_name,
      'last_name' => Faker::Name.last_name,
      'email' => Faker::Internet.email,
      'password' => 'test1234',
      'password_confirmation' => 'test1234'
    } }
  end
  let(:invalid_params) do
    { 'customer' => {
      'first_name' => Faker::Name.first_name,
      'last_name' => Faker::Name.last_name,
      'email' => Faker::Internet.email,
      'password' => 'test1123123',
      'password_confirmation' => 'test1234'
    } }
  end
  describe 'POST #create' do
    it 'return 200 with valid params and create customer' do
      post :create, params: valid_params
      expect do
        CustomerWelcomeMailer.send_welcome_email(Customer.last).deliver
      end .to change(ActionMailer::Base.deliveries, :count).by 1
      expect(response.status).to eq(200)
    end

    it 'return 422 with invalid params' do
      post :create, params: invalid_params
      expect(response.status).to eq(422)
    end
  end
end
