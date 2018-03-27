require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '.acquire_access_token!' do
    let(:customer) { FactoryBot.create(:customer) }
    it 'return access_token if exist' do
      access_token = 'fksahdfkadbshbkjdfsa'
      customer.access_token = access_token
      customer.save!
      customer.acquire_access_token!
      expect(customer.access_token).to eq(access_token)
    end

    it 'generate new access_token if it does not exist' do
      expect { customer.acquire_access_token! }
        .to change { customer.access_token }.from(nil)
    end
  end
end
