require 'rails_helper'

RSpec.describe Api::V1::Customers::ProposalsController, type: :controller do
  let(:customer) { FactoryBot.create(:customer) }
  let(:agent) { FactoryBot.create(:agent) }
  let(:job) { FactoryBot.create(:job) }
  let(:proposal) { FactoryBot.create(:proposal) }
  describe 'GET #show' do
    it 'return 200 with message' do
      proposal.agent = agent
      proposal.job = job
      proposal.save!
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.hashed_id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Propuesta listada exitosamente'
      )
    end
    it 'return 404 if job doesnt exist' do
      proposal.agent = agent
      proposal.job = job
      proposal.save!
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: {
        job_id: proposal.job.id,
        id: proposal.hashed_id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El trabajo no existe'
      )
    end
    it 'return 404 if proposal doesnt exist' do
      proposal.agent = agent
      proposal.job = job
      proposal.save!
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :show, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'La propuesta no existe'
      )
    end
  end

  describe 'GET #accepted' do
    it 'return 200 with message' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :accepted, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.hashed_id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Propuesta aceptada exitosamente'
      )
    end
    it 'change status to accepted' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :accepted, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.hashed_id
      }
      expect(Proposal.last.status).to eq('accepted')
    end
    it 'return 404 if job doesnt exist' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :accepted, params: {
        job_id: proposal.job.id,
        id: proposal.hashed_id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El trabajo no existe'
      )
    end
    it 'return 404 if proposal doesnt exist' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :accepted, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'La propuesta no existe'
      )
    end
  end

  describe 'GET #refused' do
    it 'return 200 with message' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :refused, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.hashed_id
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Propuesta rechazada exitosamente'
      )
    end
    it 'change status to refused' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :refused, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.hashed_id
      }
      expect(Proposal.last.status).to eq('refused')
    end
    it 'return 404 if job doesnt exist' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :refused, params: {
        job_id: proposal.job.id,
        id: proposal.hashed_id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El trabajo no existe'
      )
    end
    it 'return 404 if proposal doesnt exist' do
      customer.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{customer.access_token}"
      get :refused, params: {
        job_id: proposal.job.hashed_id,
        id: proposal.id
      }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'La propuesta no existe'
      )
    end
  end
end
