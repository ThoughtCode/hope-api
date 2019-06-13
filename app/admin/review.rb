ActiveAdmin.register Review do
  permit_params :job_id, :owner_type, :owner_id, :comment, :qualification
  actions :all, :except => :destroy
end
