module Api::V1::Customers
  class ReviewsController < CustomerUsersController
    include Serializable
    before_action :review_params, only: :create
    before_action :set_job, only: :create
    before_action :set_review, only: :show
    before_action :set_agent, only: :agent_reviews

    def index
      reviews = current_user.my_qualifications
      return set_response(404, 'Usted no posee calificaciones') if reviews.blank?
      set_response(
        200, 'Calificaciones listadas exitosamente', serialize_review(reviews)
      )
    end

    def create
      review = @job.reviews.new(@review_params)
      review.reviewee = @job.agent
      if review.save
        set_response(
          200, 'Calificación creada exitosamente', serialize_review(review)
        )
      else
        set_response(422, review.errors.messages.values.join(', '))
      end
    end

    def show
      review = current_user.my_job_review(@review.job)
      unless review.blank?
        return set_response(
          200, 'Calificación encontrada exitosamente', serialize_review(review)
        )
      end
      set_response(422, 'Usted no ha sido calificado')
    end

    def agent_reviews
      if @agent
        reviews = @agent.my_qualifications
        set_response(
          200, 'Calificaciónes encontradas exitosamente', serialize_review(reviews)
        )
      else
        set_response(404, 'El cliente no existe')
      end
    end

    private

    def review_params
      @review_params = params.require(:review)
                             .permit(:qualification, :comment)
                             .merge(owner: current_user)
    end

    def set_agent
      @agent = Agent.find_by(hashed_id: params[:agent_id])
    end

    def set_job
      @job = current_user.jobs
                         .eager_load(:reviews)
                         .find_by(hashed_id: params[:job_id])
    end

    def set_review
      job = current_user.jobs.find_by(hashed_id: params[:id])
      return set_response(404, 'Calificación no encontrada') if job.blank?
      @review = job.reviews.first
    end
  end
end
