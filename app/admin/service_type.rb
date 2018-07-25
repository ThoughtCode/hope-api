ActiveAdmin.register ServiceType do
  permit_params :name, :image

  filter :services
  filter :name
end
