module Api::V1::Agents
  class JobsController < AgentUsersController
    include Serializable
    before_action :set_job, only: :show

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

    def accepted
      jobs = current_user.jobs.accepted.order(id: :desc)
      jobs = filter(params, jobs)
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
      jobs = filter(params, jobs)
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
      jobs = jobs.where('started_at >= ?', flt[:date_from]) if flt[:date_from] != 'null' && !flt[:date_from].nil?
      jobs = jobs.where('started_at <= ?', flt[:date_to]) if flt[:date_to] != 'null' && !flt[:date_to].nil?
      jobs = jobs.where('total >= ?', flt[:min_price]) if flt[:min_price] != '0' && !flt[:min_price].nil?
      jobs = jobs.where('total <= ?', flt[:max_price]) if flt[:max_price] != '0' && !flt[:max_price].nil?
      jobs = jobs.where(frequency: flt[:frequency]) if flt[:frequency] != 'null' && !flt[:frequency].nil?
      jobs
    end
  end
end
