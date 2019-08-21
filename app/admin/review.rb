ActiveAdmin.register Review do
  actions :all, :except => :destroy
  permit_params :job_id, :owner_type, :owner_id, :comment, :qualification, :reviewee_id, :reviewee_type

  index do
    selectable_column
    id_column
    column :job_id
    column :owner, as: 'Calificador'
    column :reviewee, as: 'Calificado'
    column :qualification
    column :comment
    column "" do |resource|
      links = ''.html_safe
      links += link_to 'View', resource_path(resource), class: "member_link show_link"
      links += link_to 'Edit', edit_resource_path(resource), class: "member_link edit_link"
      links
    end
  end

  form do |f|
    f.inputs do
      f.input :job, :label => 'Trabajo', as: :select, :collection => Job.all.order(id: :desc).map{|j| ["#{j.id} #{j.property.name} #{j.property.customer.full_name}", j.id]}
      f.input :owner_id, label: 'Calificador ID'
      f.input :owner_type, label: 'Calificador Tipo'
      f.input :comment
      f.input :qualification
      f.input :reviewee_id, label: 'Calificado ID'
      f.input :reviewee_type, label: 'Calificado Tipo'
      f.actions
    end
  end


  controller do
    def update
      review = Review.find(params[:id])
      review_params = params[:review]
      review.update_columns(job_id: review_params[:job_id], owner_id: review_params[:owner_id], owner_type: review_params[:owner_type],
        comment: review_params[:comment], qualification: review_params[:qualification], reviewee_id: review_params[:reviewee_id],
        reviewee_type: review_params[:reviewee_type]
      )
      redirect_to admin_reviews_path
    end
  end
end
