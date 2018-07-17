module Api::V1::Customers
  class JobsController < CustomerUsersController
    include Serializable
    before_action :set_job, only: %i[show update destroy cancelled can_review]
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
            set_response(200, 'Trabajo actualizado exitosamente',
                         serialize_job(@job))
          else
            set_response(422, @job.errors)
          end
        else
          set_response(404, 'El trabajo no existe.')
        end
      else
        set_response(404, 'El trabajo no existe.')
      end
    end

    def destroy
      if @job
        if !check_ownership
          @job.destroy
          set_response(200, 'El trabajo fue borrado exitosamente.')
        else
          set_response(404, 'El trabajo no existe.')
        end
      else
        set_response(404, 'El trabajo no existe.')
      end
    end

    def show
      if @job
        if !check_ownership
          set_response(200, 'El trabajo fue encontrado exitosamente.',
                       serialize_job(@job))
        else
          set_response(404, 'El trabajo no existe.')
        end
      else
        set_response(404, 'El trabajo no existe')
      end
    end

    def can_review
      if @job
        if !check_ownership
          can = @job.can_review?(current_user)
          can_msg = if can
                      'El trabajo fue encontrado exitosamente.'
                    else
                      'No puedes realizar esta calificacion en este momento'
                    end
          render status: 200, json: {
            message: can_msg,
            can_review: can
          }
        else
          set_response(404, 'El trabajo no existe.')
        end
      else
        set_response(404, 'El trabajo no existe.')
      end
    end

    def cancelled
      if @job
        @job.set_job_to_cancelled
        @job.save
        set_response(
          200,
          'Trabajo cancelado exitosamente'
        )
      else
        set_response(
          404,
          'El trabajo no existe'
        )
      end
    end

    private

    def job_params
      params
        .require(:job)
        .permit(:property_id, :started_at, :frequency, :details,
                job_details_attributes: %i[id service_id value _destroy])
    end

    def set_job
      @job = Job.find_by(hashed_id: params[:id] || params[:job_id])
    end

    def check_ownership
      @job.property.customer != current_user
    end

    def check_status(jobs)
      if params[:status] == 'nextjobs'
        jobs = jobs.where(
          'finished_at > ? AND (status = ? OR status = ?)', DateTime.current, 0, 1
        )
      elsif params[:status] == 'history'
        jobs = jobs.where(
          'started_at < ? AND (status = ? )', DateTime.current, 4
        )
        byebug
      end
      jobs
    end
  end
end
