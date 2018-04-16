module Responsable
  extend ActiveSupport::Concern
  def set_response(status, message, data = [])
    json = data.as_json.any? ? data.as_json['data'] : data
    data_name = 'data'
    resource_name = if json.any?
                      json.is_a?(Array) ? json.first['type'] : json['type']
                    end
    data_name = resource_name if json.any?
    render status: status, json: {
      message: message,
      data_name => data
    }
  end
end
