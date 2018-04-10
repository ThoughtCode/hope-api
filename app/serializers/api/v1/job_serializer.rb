class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  attributes :property_id, :date, :duration, :total, :status

  attribute :job_details do |j|
    j.job_details.as_json(except: [:job_id], include: [:service])
  end
end
