module Api::V1
  class ApiController < ActionController::API
    include ActionController::MimeResponds
    include ActionController::HttpAuthentication::Token::ControllerMethods
    respond_to :json
    rescue_from Exception, with: :render_internal_server_error
    rescue_from ActiveRecord, with: :render_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :active_model_errors
    before_action :cors_set_access_control_headers

    def cors_default_options_check
      options = request.method == 'OPTIONS'
      headers['Access-Control-Max-Age'] = '1728000' if options
      render json: '' if options
    end

    private

    def current_user
      @user
    end

    def disable_access_by_tk
      authenticate_or_request_with_http_token do |token|
        @user = find_by_token(token)
        unless @user
          set_response(401,
                       'HTTP Token: Access denied.')
        end
        @user
      end
    rescue StandardError => e
      Rails.logger.error e
    end

    def find_by_token(token)
      Agent.find_by(access_token: token) ||
        Customer.find_by(access_token: token)
    end

    def render_internal_server_error(exception)
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      Rails.logger.error("ERROR api call: #{exception.message}")
      Rails.logger.error(exception.backtrace.join("\n"))
      set_response(500, exception.message)
    end

    def render_unauthorized
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(401, 'email/password mismatch')
    end

    def render_forbidden
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(403, 'forbidden')
    end

    def record_not_found(_exception)
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(404, 'record not found')
    end

    def active_model_errors(_exception)
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(400, exception.record.errors.full_messages)
    end

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
end
