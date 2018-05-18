FactoryBot.define do
  factory :proposal do
    agent
    job
    status :pending
  end
end
