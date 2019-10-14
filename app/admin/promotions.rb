ActiveAdmin.register Promotion do
  permit_params :name, :code_promotion, :created_at, :finingdate_at, :service_id

  index do
    selectable_column
    id_column
    column :name
    column :code_promotion
    column :service_id do |s|
      "#{s.service.name}"
    end
    column :created_at
    column :finingdate_at
  end

  show do
    attributes_table do
      row :name
      row :code_promotion
      row :service_id {|s| s.service.name}
      row :created_at
      row :finingdate_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :code_promotion
      f.input :service_id, :label => 'Service', :as => :select, :collection => Service.all.map{|s| ["#{s.name}", s.id]}
      f.input :created_at
      f.input :finingdate_at
      f.actions
    end
  end

end
