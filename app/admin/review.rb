ActiveAdmin.register Review do
  permit_params :job_id, :owner_type, :owner_id, :comment, :qualification, :reviewee_id, :reviewee_type
  actions :all, :except => :destroy
end
