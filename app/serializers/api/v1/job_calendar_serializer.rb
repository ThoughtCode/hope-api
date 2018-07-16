class Api::V1::JobCalendarSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id

  attribute :title do |j|
    j.job_details.select { |jd| jd.service.type_service == 'base' }.first.service.name
  end

  attribute :start, &:started_at

  attribute :end, &:finished_at

  attribute :url do |j|
    ENV['FRONTEND_URL'] + '/agente/trabajo/' + j.hashed_id.to_s
  end
end
