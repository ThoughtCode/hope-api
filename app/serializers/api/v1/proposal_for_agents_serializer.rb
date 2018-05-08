class Api::V1::ProposalForAgentsSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :id, :job
end
