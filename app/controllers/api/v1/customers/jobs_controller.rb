module Api::V1::Customers
  class JobsController < CustomerUsersController
    include Serializable
    before_action :set_job, only: %i[show update destroy cancelled can_review]
    
    def index
      jobs = current_user.jobs.all
      jobs = check_status(jobs)
      jobs = jobs.order(started_at: :desc).page(params[:current_page]).per(params[:limit])
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.page(1).total_pages
      )
    end

    def completed
      jobs = current_user.jobs.where(status: ['completed', 'pending', 'accepted', 'cancelled']).where( 'started_at <= ?', DateTime.current)
      jobs = jobs.order(started_at: :desc).page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.total_pages
      )
    end

    def current
      jobs = current_user.jobs.where(status: ['pending', 'accepted']).where(
        'started_at > ?', DateTime.current
      )
      jobs = jobs.order(started_at: :desc).page(params[:current_page]).per(10)
      set_response(
        200,
        'Trabajos listados exitosamente',
        serialize_job(jobs),
        jobs.total_pages
      )
    end

    def create
      job = Job.new(job_params)
      job_details = job.job_details.select {|j| j.value != 0}
      job.job_details = job_details
      # cc = CreditCard.find(params[:job][:credit_card_id])
      # job.credit_card = cc
      Rails.logger.info('*************************')
      Rails.logger.info(job_params)
      Rails.logger.info('*************************')
      Rails.logger.info(pp(job))
      Rails.logger.info('*************************')
      if job.save
        payment = Payment.create_with(credit_card_id: params[:job][:credit_card_id], amount: job.total, vat: job.vat, status: 'Pending', 
                                      installments: job.installments, customer: job.property.customer).find_or_create_by(job_id: job.id)
        payment.amount = job.total
        payment.vat = job.vat
        payment.installments = job.installments
        payment.description = "Trabajo de limpieza NocNoc Payment_id:#{payment.id}"
        payment.save!
        # Create Invoice (Mandar para cuando se cobre)
        Invoice.create(customer: current_user, job: job, invoice_detail_id: params[:job][:invoice_detail_id])
        set_response(200, 'Servicio programado con éxito, recibirás propuestas de nuestros agentes', serialize_job(job))
      else
        set_response(422, job.errors.messages.values.join(', '))
      end
    end

    def update
      if @job
        if !check_ownership
          if @job.update(job_params)
            set_response(200, 'Trabajo actualizado exitosamente',
                         serialize_job(@job))
          else
            set_response(422, @job.errors.messages.values.join(', '))
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
        .permit(:property_id, :started_at, :source, :invoice_detail, :credit_card, :frequency, :details, :finished_recurrency_at, :installments,
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
          'started_at >= ? AND (status = ? OR status = ?)', DateTime.current, 0, 1
        )
      elsif params[:status] == 'history'
        jobs = jobs.where(
          'started_at <= ? AND (status = ? OR status = ?)', DateTime.current, 3, 1
        )
      end
      jobs
    end
  end
end
