ActiveAdmin.register Job do
  permit_params :property_id, :started_at, :status, :frequency, :agent_id, :source, job_details_attributes: [:id, :service_id, :value, :_destroy ]


  show do
    attributes_table do
      row :property
      row :started_at do |j|
        j.started_at
      end
      row :finished_at do |j|
        j.finished_at
      end
      row :finished_recurrency_at do |j|
        j.finished_recurrency_at.localtime if j.finished_recurrency_at
      end
      row :duration
      row :status
      row :frequency
      row :details
      row :card
      row :installments
      row :total
      row :vat
      row :service_fee
      row :subtotal
      row :agent_earnings
      row :agent
      row :payment
    end
    panel "Detalles" do
      job_details = Job.find(params['id']).job_details
      table_for job_details do
        column :service
        column :value
        column :price_total
      end
    end
  end

  filter :agent
  filter :property
  filter :duration
  filter :total
  filter :started_at
  filter :finished_at
  filter :status
  filter :frequency

  index do
    selectable_column
    id_column
    column :property
    column :duration
    column :agent
    column :total
    column :status
    column :source
    column :started_at do |j|
      j.started_at.localtime
    end
    column :frequency
    actions
  end

  form do |f|
    f.inputs 'Trabajos' do
      f.input :property
      f.input :started_at
      f.input :status
      f.input :frequency
      f.has_many :job_details, allow_destroy: true, heading: 'Detalles' do |d|
        d.input :service
        d.input :value
      end
      f.input :agent, as: :select, collection: Agent.all.map{|a| ["#{a.first_name} #{a.last_name}" , a.id] }
    end
    f.actions
  end

  controller do
    def update
      @job = Job.find(params[:id])

      super
    end
  end

end
