ActiveAdmin.register Service do
  permit_params :service_type_id, :type_service, :name, :quantity, :time, :price,
                :icon
end
