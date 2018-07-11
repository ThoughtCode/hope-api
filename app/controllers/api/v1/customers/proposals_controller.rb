module Api::V1::Customers
  class ProposalsController < CustomerUsersController
    include Serializable
    before_action :set_job

    def show
      if @job
        proposal = @job.proposals.find_by(hashed_id: params[:id])
        if proposal
          set_response(
            200, 'Propuesta listada exitosamente', serialize_proposal(proposal)
          )
        else
          set_response(
            404, 'La propuesta no existe'
          )
        end
      else
        set_response(
          404, 'El trabajo no existe'
        )
      end
    end

    def accepted
      if @job
        proposal = @job.proposals.find_by(hashed_id: params[:id])
        if proposal
          if proposal.can_accept_agent
            proposal.set_proposal_to_job
            set_response(
              200, 'Propuesta aceptada exitosamente', serialize_job(@job)
            )
          else
            set_response(422,
                         'El agente ya tiene un trabajo asignado en esta fecha',
                         serialize_job(@job))
          end
        else
          set_response(404, 'La propuesta no existe')
        end
      else
        set_response(404, 'El trabajo no existe')
      end
    end

    def refused
      if @job
        proposal = @job.proposals.find_by(hashed_id: params[:id])
        if proposal
          proposal.set_to_refused
          proposal.save
          set_response(
            200, 'Propuesta rechazada exitosamente'
          )
        else
          set_response(404, 'La propuesta no existe')
        end
      else
        set_response(404, 'El trabajo no existe')
      end
    end

    private

    def set_job
      @job = Job.find_by(hashed_id: params[:job_id])
    end
  end
end
