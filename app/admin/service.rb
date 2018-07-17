ActiveAdmin.register Service do
  permit_params :service_type_id, :type_service, :name, :quantity, :time, :price,
                :icon

  index do
    selectable_column
    id_column
    column :service_type
    column :type_service
    column :name
    column :quantity
    column :time
    column :price
    actions
  end
end
