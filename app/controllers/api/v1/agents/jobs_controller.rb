class Api::V1::Agents::JobsController < Api::V1::ApiController
  include Serializable
  before_action :set_job

  def show
    if @job
      set_response(200, 'Trabajo econtrado existosamente.',
                   serialize_job_for_agents(@job))
    else
      set_response(404, 'El trabajo no existe')
    end
  end

  private

  def set_job
    @job = Job.find_by(hashed_id: params[:id])
  end
end
