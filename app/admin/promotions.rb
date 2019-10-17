ActiveAdmin.register Promotion do
  actions :all, :except => :destroy
  permit_params :name, :promo_code, :started_at, :finished_at, :service_id, :discount, :status

  index do
    selectable_column
    id_column
    column :name
    column :promo_code
    column :started_at
    column :finished_at
    column :service
    column :discount
    column :status
    actions
  end

  show do
    attributes_table do
      row :name
      row :promo_code
      row :started_at
      row :finished_at
      row :service
      row :discount
      row :status
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :promo_code
      f.input :service_id, :label => 'Service', as: :select, :collection => Service.all.map{|s| ["#{s.name}", s.id]}
      f.input :started_at, :as => :datepicker, :html_option => { value: Time.now }
      f.input :finished_at, :as => :datepicker, :html_option => { value: Time.now }
      f.input :discount
      f.input :status
      f.actions
    end
  end

end
