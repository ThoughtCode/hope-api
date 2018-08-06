module Api::V1::Agents
  class JobsController < AgentUsersController
    include Serializable
    before_action :set_job, only: %i[show can_review can_apply]

    def index
      proposals = current_user.proposals.pluck(:job_id)
      jobs = Job.all.where('started_at > ?', Date.current).pending.order(started_at: :asc)
      jobs = filter(params, jobs)
      jobs = jobs.where.not(id: proposals)
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.total_pages
      )
    end

    def postulated
      proposals = current_user.proposals.pluck(:job_id)
      jobs = Job.all.where('started_at > ?', Date.current).pending.order(started_at: :asc)
      jobs = jobs.where(id: proposals)
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.total_pages
      )
    end

    def accepted
      jobs = current_user.jobs.accepted.order(id: :desc)
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

    def calendar
      jobs = current_user.jobs.where(status: %i[accepted completed pending]).order(id: :desc)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job_calendar(jobs)
      )
    end

    def completed
      jobs = current_user.jobs.completed.order(id: :desc)
      jobs = jobs.page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

    def show
      set_response(200, 'Trabajo econtrado existosamente.',
                   serialize_job_for_agents(@job))
    end

    def can_review
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
    end

    def can_apply
      can = !@job.proposals.where(agent: current_user).exists?
      can_msg = if can
                  'El trabajo fue encontrado exitosamente.'
                else
                  'No puedes aplicar a este trabajo'
                end
      render status: 200, json: {
        message: can_msg,
        can_apply: can
      }
    end

    private

    def set_job
      @job = Job.find_by(hashed_id: params[:id] || params[:job_id])
      return set_response(404, 'El trabajo no existe.') unless @job
    end

    def filter(flt, jobs)
      jobs = jobs.where('started_at >= ?', flt[:date_from]) if flt[:date_from] != 'null' && !flt[:date_from].nil?
      jobs = jobs.where('started_at <= ?', flt[:date_to]) if flt[:date_to] != 'null' && !flt[:date_to].nil?
      jobs = jobs.where('total >= ?', flt[:min_price]) if flt[:min_price] != '' && !flt[:min_price].nil?
      jobs = jobs.where('total <= ?', flt[:max_price]) if flt[:max_price] != '' && !flt[:max_price].nil?
      jobs = jobs.where(frequency: flt[:frequency]) if flt[:frequency] != 'null' && !flt[:frequency].nil?
      jobs
    end
  end
end
