ActiveAdmin.register Config do
  permit_params :key, :value, :description

  index do
    selectable_column
    id_column
    column :description
    column :value
    column "" do |resource|
      links = ''.html_safe
      links += link_to 'View', resource_path(resource), class: "member_link show_link"
      links += link_to 'Edit', edit_resource_path(resource), class: "member_link edit_link"
      links
    end
  end

  form do |f|
    atts = {}
    f.semantic_errors *f.object.errors.keys
    f.inputs "Config Details" do
      unless f.object.new_record?
        atts = {:readonly => true, :disabled => true}
      end
      f.input :key, :input_html => atts
      f.input :value
      f.input :description
    end
    f.actions
  end

  controller do

    def show
    end

    def create
      config =  Config.new(config_params)
      if config.save
        redirect_to admin_configs_path, notice: 'Configuration created sucessfuly'
      else
        redirect_to new_admin_config_path, alert: config.errors.full_messages
      end
    end

    def update
      config = Config.find(params['id'])
      if config.update(config_params.except(:key))
        redirect_to admin_configs_path, notice: 'Configuration updated sucessfuly'
      else
        redirect_to new_admin_config_path, alert: config.errors.full_messages
      end
    end

    def delete
      redirect_to admin_configs_path, notice: 'Configuration cannot be deleted'
    end

    private

    def config_params
      params.require(:config).permit(:key, :value, :description)
    end
  end
end