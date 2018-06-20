module Api::V1::Agents
  class JobsController < AgentUsersController
    include Serializable
    before_action :set_job, only: :show

    def index
      # Agregar filtros
      jobs = Job.all.order(id: :desc)
      jobs = filter(params[:filter], jobs) if params[:filter]
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

    def accepted
      jobs = current_user.jobs.pending.order(id: :desc)
      jobs = filter(params[:filter], jobs) if params[:filter]
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

    def completed
      jobs = current_user.jobs.completed.order(id: :desc)
      jobs = filter(params[:filter], jobs) if params[:filter]
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

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

    def filter(flt, jobs)
      jobs = jobs.where('started_at >= ?', flt[:date_from]) if flt[:date_from]
      jobs = jobs.where('started_at <= ?', flt[:date_to]) if flt[:date_to]
      jobs = jobs.where('total >= ?', flt[:min_price]) if flt[:min_price]
      jobs = jobs.where('total <= ?', flt[:max_price]) if flt[:max_price]
      jobs = jobs.where(frequency: flt[:frequency]) if flt[:frequency]
      jobs
    end
  end
end
