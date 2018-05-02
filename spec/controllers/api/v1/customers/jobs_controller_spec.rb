require 'rails_helper'

RSpec.describe Api::V1::Customers::JobsController, type: :controller do
  include ActiveJob::TestHelper
  include Serializable
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @request.env['devise.mapping'] = Devise.mappings[:customer]
  end
  let(:customer) { FactoryBot.create(:customer) }
  let(:agent) { FactoryBot.create(:agent) }
  let(:property) { FactoryBot.create(:property) }
  let(:service) { FactoryBot.create(:service) }
  let(:job) { FactoryBot.create(:job) }
  let(:customer2) { FactoryBot.create(:customer) }
  let(:url) { ENV['FRONTEND_URL'] }
  describe 'GET #index' do
    it 'return 200 with array of jobs' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :index
      expect(JSON.parse(response.body)).to include('message' => 'Trabajos '\
        'listados exitosamente')
    end
  end

  describe 'POST #create' do
    it 'return 200 with message successfully' do
      FactoryBot.create_list(:agent, 3)
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      expect do
        post :create, params: { job:
        {
          property_id: property.id,
          started_at: Time.current + 3.hours,
          job_details_attributes: [{
            service_id: service.id,
            value: 1
          }]
        } }
      end .to change(Job, :count).by(1)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Trabajo '\
        'creado exitosamente')
    end
    it 'send email to agents if availability' do
      FactoryBot.create_list(:agent, 3)
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      post :create, params: { job:
      {
        property_id: property.id,
        started_at: Time.current + 3.hours,
        job_details_attributes: [{
          service_id: service.id,
          value: 1
        }]
      } }
      expect do
        SendEmailToAgentsJob.perform_later(Job.last.hashed_id, url)
      end .to enqueue_job
      perform_enqueued_jobs do
        SendEmailToAgentsJob.perform_later(Job.last.hashed_id, url)
      end
    end
    it 'return 422 with invalid params' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      post :create, params: { job: {
        property_id: property.id,
        started_at: Time.current - 1.days,
        job_details_attributes: [{
          service_id: service.id,
          value: '1'
        }]
      } }
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT #update' do
    it 'return 200 with message successfully' do
      customer = job.property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      patch :update, params: { id: job.hashed_id, job:
        {
          property_id: job.property.id,
          started_at: job.started_at,
          job_details_attributes: [{
            service_id: service.id,
            value: 1
          }]
        } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Updated job'\
        ' successfully')
    end
    it 'return 422 if invalid params' do
      customer = job.property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { id: job.hashed_id, job:
        {
          property_id: job.property.id,
          started_at: job.started_at,
          job_details_attributes: [{
            service_id: 'asd',
            value: 1
          }]
        } }
      expect(response.status).to eq(422)
    end
    it 'return 404 if job not found' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      put :update, params: { id: 'asdasd', job:
        {
          property_id: job.property.id,
          started_at: job.started_at,
          job_details_attributes: [{
            service_id: service.id,
            value: 1
          }]
        } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Job does'\
        ' not exists.')
    end
    it 'return 404 if property not ownership' do
      customer2.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer2.access_token}"
      put :update, params: { id: job.hashed_id, job:
        {
          property_id: job.property.id,
          started_at: job.started_at,
          job_details_attributes: [{
            service_id: service.id,
            value: 1
          }]
        } }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Job does'\
        ' not exists.')
    end
  end

  describe 'DELETE #destroy' do
    it 'return 200 if deleted succesfully' do
      customer = job.property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      delete :destroy, params: { id: job.hashed_id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Job was '\
        'deleted successfully.')
    end
    it 'reutrn 404 if not exists' do
      customer = job.property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      delete :destroy, params: { id: 'asd' }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Job does'\
        ' not exists.')
    end
    it 'return 404 if not owner' do
      customer2.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer2.access_token}"
      delete :destroy, params: { id: job.hashed_id }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Job does'\
        ' not exists.')
    end
  end

  describe 'GET #show' do
    it 'return 200 if deleted succesfully' do
      customer = job.property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: { id: job.hashed_id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('message' => 'Job found '\
        'successfully.', 'job' => serialize_job(job).as_json)
    end
    it 'reutrn 404 if not exists' do
      customer = job.property.customer
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: { id: 'asd' }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Job does'\
        ' not exist.')
    end
    it 'return 404 if not owner' do
      customer2.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer2.access_token}"
      get :show, params: { id: job.hashed_id }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include('message' => 'Job '\
        'does not exists.')
    end
  end
end
