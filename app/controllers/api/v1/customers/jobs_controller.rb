class Api::V1::Customers::JobsController < Api::V1::ApiController
  include Serializable
  before_action :set_job, only: %i[show update destroy]

  def index
    jobs = current_user.jobs.all
    set_response(
      200,
      'Jobs successfully listed.',
      serialize_job(jobs)
    )
  end

  def create
    job = Job.new(job_params)
    job.status = 0
    if job.save
      set_response(200, 'Job created', serialize_job(job))
    else
      set_response(422, job.errors)
    end
  end

  def update
    if @job
      if !check_ownership
        if @job.update(job_params)
          set_response(200, 'Updated job successfully',
                       serialize_job(@job))
        else
          set_response(:unprocessable_entity, @job.errors)
        end
      else
        set_response(404, 'Job does not exists.')
      end
    else
      set_response(404, 'Job does not exists.')
    end
  end

  def destroy
    if @job
      if !check_ownership
        @job.destroy
        set_response(:ok, 'Job was deleted successfully.')
      else
        set_response(404, 'Job does not exists.')
      end
    else
      set_response(404, 'Job does not exists.')
    end
  end

  def show
    if @job
      if !check_ownership
        set_response(:ok, 'Job founded successfully.',
                     serialize_job(@job))
      else
        set_response(404, 'Job does not exists.')
      end
    else
      set_response(404, 'Job does not exist.')
    end
  end

  private

  def job_params
    params
      .require(:job)
      .permit(:property_id, :date,
              job_details_attributes: %i[id service_id value _destroy])
  end

  def set_job
    @job = Job.find_by(id: params[:id])
  end

  def check_ownership
    @job.property.customer != current_user
  end
end
