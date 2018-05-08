require 'rails_helper'

RSpec.describe Api::V1::Agents::ProposalsController, type: :controller do
  let(:agent) { FactoryBot.create(:agent) }
  let(:job) { FactoryBot.create(:job) }
  let(:proposal) { FactoryBot.create(:proposal) }
  describe 'GET #index' do
    it 'return 200 with the proposals' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      get :index
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include('message' => 'Propuestas '\
        'listadas exitosamente')
    end
  end

  describe 'POST #create' do
    it 'return 200 with message' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      expect do
        post :create, params: {
          job_id: job.hashed_id
        }
      end .to change(Proposal, :count).by(1)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'Se ha postulado exitosamente'
      )
    end
    it 'return 422 if agent have jobs' do
      job = FactoryBot.create(:job_with_details, :one_day_ago)
      job.save!
      agent = job.agent
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      expect do
        post :create, params: {
          job_id: job.hashed_id
        }
      end .to change(Proposal, :count).by(0)
      expect(response.status).to eq(422)
    end
    it 'return 404 if job doesnt not exist' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      expect do
        post :create, params: {
          job_id: agent.id
        }
      end .to change(Proposal, :count).by(0)
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El trabajo no existe'
      )
    end
  end

  describe 'DELETE #destroy' do
    it 'return 200 with message' do
      agent.acquire_access_token!
      proposal.agent = agent
      proposal.job = job
      proposal.save!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      expect do
        delete :destroy, params: {
          job_id: job.hashed_id,
          id: proposal.hashed_id
        }
      end .to change(Proposal, :count).by(-1)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to include(
        'message' => 'La propuesta ha sido eliminada exitosamente'
      )
    end
    it 'return 404 if proposal doesnt not exist' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      expect do
        delete :destroy, params: {
          job_id: job.hashed_id,
          id: job.hashed_id
        }
      end .to change(Proposal, :count).by(0)
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'La propuesta no existe'
      )
    end
    it 'return 404 if job doesnt exist' do
      agent.acquire_access_token!
      @request.env['HTTP_AUTHORIZATION'] = "Token #{agent.access_token}"
      expect do
        delete :destroy, params: {
          job_id: agent.id,
          id: agent.id
        }
      end .to change(Proposal, :count).by(0)
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)).to include(
        'message' => 'El trabajo no existe'
      )
    end
  end
end
