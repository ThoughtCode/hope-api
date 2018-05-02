class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id # optional
  attributes :id, :property_id, :started_at, :finished_at, :duration, :total,
             :status

  attribute :job_details do |j|
    j.job_details.as_json(except: [:job_id], include: [:service])
  end
end
