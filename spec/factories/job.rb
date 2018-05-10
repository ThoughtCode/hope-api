FactoryBot.define do
  factory :job do
    property
    started_at Time.current + 1.hours

    factory :job_with_details do
      agent
      transient do
        job_details_count 5
      end

      trait :one_day_ago do |j|
        j.started_at Time.current - 1.days
      end

      trait :six_hours_ago do |j|
        j.started_at Time.current - 6.hours
      end

      trait :three_hours_ago do |j|
        j.started_at Time.current - 3.hours
      end

      trait :six_hour_future do |j|
        j.started_at Time.current + 6.hours
      end

      trait :one_day_future do |j|
        j.started_at Time.current + 1.days
      end

      after(:create) do |job, evaluator|
        create_list(:job_detail, evaluator.job_details_count, job: job)
      end
    end
  end
end
