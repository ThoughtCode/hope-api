require 'rails_helper'

RSpec.describe SendEmailToAgentsJob, type: :job do
  # let(:job) { FactoryBot.create(:job) }
  # describe '#perform_later' do
  #   it 'send email' do
  #     ActiveJob::Base.queue_adapter = :test
  #     SendEmailToAgentsJob.perform_later(job.hashed_id, ENV['FRONTEND_URL'])
  #     expect(SendEmailToAgentsJob).to have_been_enqueued.at_least(1).times
  #   end
  # end
end
