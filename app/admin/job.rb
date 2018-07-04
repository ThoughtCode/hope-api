ActiveAdmin.register Job do
  permit_params :property_id, :started_at, :status, :frequency, job_details_attributes: [ :service_id, :value ]

  show do
    attributes_table do
      row :property
      row :started_at
    end
    panel "Detalles" do
      job_details = Job.find(params['id']).job_details
      table_for job_details do
        column :service_id
        column :value
      end
    end
  end

  form do |f|
    f.inputs 'Trabajos' do
      f.input :property
      f.input :started_at
      f.input :status
      f.input :frequency
      f.has_many :job_details, heading: 'Detalles' , new_record: "Añadir un nuevo detalle" do |d|
        d.input :service
        d.input :value
      end
    end
    f.actions
  end
end
