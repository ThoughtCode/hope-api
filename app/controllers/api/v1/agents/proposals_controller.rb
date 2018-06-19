module Api::V1::Agents
  class ProposalsController < AgentUsersController
    include Serializable
    before_action :set_job, only: %i[create destroy]
    before_action :set_proposal, only: %i[destroy]

    def index
      proposals = current_user.proposals
      set_response(
        200, 'Propuestas listadas exitosamente',
        serialize_proposal_for_agents(proposals)
      )
    end

    def create
      if @job
        proposal = Proposal.new(
          job: @job, agent: current_user, status: 'pending'
        )
        if proposal.save
          set_response(200, 'Se ha postulado exitosamente')
        else
          set_response(422, proposal.errors)
        end
      else
        set_response(404, 'El trabajo no existe')
      end
    end

    def destroy
      if @job
        if @proposal
          @proposal.destroy
          set_response(200, 'La propuesta ha sido eliminada exitosamente')
        else
          set_response(404, 'La propuesta no existe')
        end
      else
        set_response(404, 'El trabajo no existe')
      end
    end

    private

    def set_proposal
      @proposal = Proposal.find_by(hashed_id: params[:id])
    end

    def set_job
      @job = Job.find_by(hashed_id: params[:job_id])
    end
  end
end
