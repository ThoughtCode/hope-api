require 'rails_helper'

RSpec.describe Api::V1::Customers::PropertiesController, type: :controller do
  include Serializable

  let(:customer) { FactoryBot.create(:customer) }
  let(:neightborhood) { FactoryBot.create(:neightborhood) }
  let(:property) { FactoryBot.create(:property) }
  let(:customer2) { FactoryBot.create(:customer) }
  describe 'GET #index' do
    it 'return 200 with array of properties' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :index
      expect(JSON.parse(response.body)).to include('message' => 'Property '\
        'successfully listed.')
    end
  end
  describe 'POST #create' do
    it 'return 200 with message successfully' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      expect do
        post :create, params: { property:
        {
          name: Faker::Company.name,
          p_street: Faker::Address.street_name,
          number: Faker::Address.building_number,
          s_street: Faker::Address.secondary_address,
          details: Faker::Address.street_address,
          cell_phone: '123456789',
          neightborhood_id: neightborhood.id
        } }
      end .to change(Property, :count).by(1)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Property'\
        ' created')
    end
    it 'return 422 with invalid params' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      post :create, params: { property: {
        name: Faker::Company.name,
        details: Faker::Address.street_address,
        cell_phone: '123456789',
        neightborhood_id: neightborhood.id
      } }
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT #update' do
    it 'return 200 with message successfully' do
      customer = property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { id: property.hashed_id, property:
        {
          name: property.name,
          p_street: property.p_street,
          number: property.number,
          s_street: property.s_street,
          details: property.details,
          cell_phone: property.cell_phone,
          neightborhood_id: property.neightborhood.id
        } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Updated property'\
        ' successfully', 'property' => serialize_property(property).as_json)
    end
    it 'return 422 if invalid params' do
      customer = property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { id: property.hashed_id, property:
        {
          name: property.name,
          p_street: property.p_street,
          number: property.number,
          s_street: property.s_street,
          details: property.details,
          cell_phone: property.cell_phone,
          neightborhood_id: 'asdasds'
        } }
      expect(response.status).to eq(422)
    end
    it 'return 404 if property not found' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { id: 'aasdasd', property:
        {
          hashed_id: 'asdasd',
          name: property.name,
          p_street: property.p_street,
          number: property.number,
          s_street: property.s_street,
          details: property.details,
          cell_phone: property.cell_phone,
          neightborhood_id: property.neightborhood.id
        } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Property does'\
        ' not exists.')
    end
    it 'return 404 if property not ownership' do
      customer2.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer2.access_token}"
      put :update, params: { id: property.hashed_id, property:
        {
          name: property.name,
          p_street: property.p_street,
          number: property.number,
          s_street: property.s_street,
          details: property.details,
          cell_phone: property.cell_phone,
          neightborhood_id: property.neightborhood.id
        } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Property does'\
        ' not exists.')
    end
  end

  describe 'DELETE #destroy' do
    it 'return 200 if deleted succesfully' do
      customer = property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      delete :destroy, params: { id: property.hashed_id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Property was '\
        'deleted successfully.')
    end
    it 'reutrn 404 if not exists' do
      customer = property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      delete :destroy, params: { id: 'asd' }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Property does'\
        ' not exists.')
    end
    it 'return 404 if not owner' do
      customer2.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer2.access_token}"
      delete :destroy, params: { id: property.hashed_id }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Property does'\
        ' not exists.')
    end
  end

  describe 'GET #show' do
    it 'return 200 if deleted succesfully' do
      customer = property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: { id: property.hashed_id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Property found '\
        'successfully.', 'property' => serialize_property(property).as_json)
    end
    it 'reutrn 404 if not exists' do
      customer = property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: { id: 'asd' }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Property does'\
        ' not exist.')
    end
    it 'return 404 if not owner' do
      customer2.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer2.access_token}"
      get :show, params: { id: property.hashed_id }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Property '\
        'does not exists.')
    end
  end
end
