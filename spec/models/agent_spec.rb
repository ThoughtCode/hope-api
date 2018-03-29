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
end
