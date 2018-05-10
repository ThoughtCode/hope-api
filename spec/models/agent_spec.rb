require 'rails_helper'

RSpec.describe Agent, type: :model do
  describe '.acquire_access_token!' do
    let(:agent) { FactoryBot.create(:agent) }
    it 'return access_token if exist' do
      access_token = 'fksahdfkadbshbkjdfsa'
      agent.access_token = access_token
      agent.save!
      agent.acquire_access_token!
      expect(agent.access_token).to eq(access_token)
    end

    it 'generate new access_token if it does not exist' do
      expect { agent.acquire_access_token! }
        .to change { agent.access_token }.from(nil)
    end
  end
  describe '.filter_by_availability' do
    it 'return 3 agents free' do
      FactoryBot.create_list(:agent, 3)
      job_dago = FactoryBot.create(:job_with_details, :one_day_ago)
      job_dago.save!
      agents = Agent.filter_by_availability(job_dago)
      expect(agents.count).to eq(3)
    end
    it 'return 3 agents free when 1 has jobs' do
      FactoryBot.create_list(:agent, 3)
      job_dago = FactoryBot.create(:job_with_details, :one_day_ago)
      job_dago.save!
      job_shours = FactoryBot.create(:job_with_details, :six_hours_ago)
      job_shours.save!
      agents = Agent.filter_by_availability(job_shours)
      expect(agents.count).to eq(4)
    end
    it 'return 2 agents free when 2 has jobs' do
      FactoryBot.create_list(:agent, 2)
      job_shours_future = FactoryBot.create(:job_with_details, :six_hour_future)
      job_shours_future.save!
      job_thours = FactoryBot.create(:job_with_details, :three_hours_ago)
      job_thours.save!
      job_shours_ago = FactoryBot.create(:job_with_details, :six_hours_ago)
      job_shours_ago.save!
      agents = Agent.filter_by_availability(job_thours)
      expect(agents.count).to eq(3)
    end
    it 'return 3 agents when all has jobs' do
      job_dfuture = FactoryBot.create(:job_with_details, :one_day_future)
      job_dfuture.save!
      job_dago = FactoryBot.create(:job_with_details, :one_day_ago)
      job_dago.save!
      job_shours_ago = FactoryBot.create(:job_with_details, :six_hours_ago)
      job_shours_ago.save!
      job_shours_future = FactoryBot.create(:job_with_details, :six_hour_future)
      job_shours_future.save!
      agents = Agent.filter_by_availability(job_shours_future)
      expect(agents.count).to eq(3)
    end
    it 'return 2 agents free when 2 has jobs and 2 are offline' do
      FactoryBot.create_list(:agent, 2)
      a1 = FactoryBot.create(:agent, :offline)
      a1.save!
      a2 = FactoryBot.create(:agent, :offline)
      a2.save!
      job_shours_future = FactoryBot.create(:job_with_details, :six_hour_future)
      job_shours_future.save!
      job_thours = FactoryBot.create(:job_with_details, :three_hours_ago)
      job_thours.save!
      job_shours_ago = FactoryBot.create(:job_with_details, :six_hours_ago)
      job_shours_ago.save!
      agents = Agent.filter_by_availability(job_thours)
      expect(agents.count).to eq(3)
    end
    it 'return 2 agents free when 2 has jobs and 2 are refused' do
      FactoryBot.create_list(:agent, 2)
      a1 = FactoryBot.create(:agent, :refused)
      a1.save!
      a2 = FactoryBot.create(:agent, :refused)
      a2.save!
      job_shours_future = FactoryBot.create(:job_with_details, :six_hour_future)
      job_shours_future.save!
      job_thours = FactoryBot.create(:job_with_details, :three_hours_ago)
      job_thours.save!
      job_shours_ago = FactoryBot.create(:job_with_details, :six_hours_ago)
      job_shours_ago.save!
      agents = Agent.filter_by_availability(job_thours)
      expect(agents.count).to eq(3)
    end
    it 'return 2 agents free when 2 has jobs and 2 are pending' do
      FactoryBot.create_list(:agent, 2)
      a1 = FactoryBot.create(:agent, :pending)
      a1.save!
      a2 = FactoryBot.create(:agent, :pending)
      a2.save!
      job_shours_future = FactoryBot.create(:job_with_details, :six_hour_future)
      job_shours_future.save!
      job_thours = FactoryBot.create(:job_with_details, :three_hours_ago)
      job_thours.save!
      job_shours_ago = FactoryBot.create(:job_with_details, :six_hours_ago)
      job_shours_ago.save!
      agents = Agent.filter_by_availability(job_thours)
      expect(agents.count).to eq(3)
    end
  end
end
