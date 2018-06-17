module Api::V1::Customers
  class JobsController < CustomerUsersController
    include Serializable
    before_action :set_job, only: %i[show update destroy]

    def index
      jobs = current_user.jobs.all
      jobs = check_status(jobs)
      jobs = jobs.page(params[:current_page]).per(params[:limit])
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

    def create
      job = Job.new(job_params)
      if job.save
        set_response(200, 'Trabajo creado exitosamente', serialize_job(job))
      else
        set_response(422, job.errors.full_messages)
      end
    end

    def update
      if @job
        if !check_ownership
          if @job.update(job_params)
            set_response(200, 'Updated job successfully',
                         serialize_job(@job))
          else
            set_response(422, @job.errors)
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
          set_response(200, 'Job was deleted successfully.')
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
          set_response(200, 'Job found successfully.',
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
        .permit(:property_id, :started_at,
                job_details_attributes: %i[id service_id value _destroy])
    end

    def set_job
      @job = Job.find_by(hashed_id: params[:id])
    end

    def check_ownership
      @job.property.customer != current_user
    end

    def check_status(jobs)
      if params[:status] == 'nextjobs'
        jobs = jobs.where(
          'finished_at > ? AND (status = ? OR status = ?)', Date.current, 0, 1
        )
      elsif params[:status] == 'history'
        jobs = jobs.where(
          'finished_at < ? AND (status = ? )', Date.current, 3
        )
      end
      jobs
    end
  end
end
