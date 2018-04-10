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
    before_action :disable_access_by_tk, except: %i[cors_default_options_check]

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
          set_response(:unauthorized,
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
      set_response(:internal_server_error, exception.message)
    end

    def render_unauthorized
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(:unauthorized, 'email/password mismatch')
    end

    def render_forbidden
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(:forbidden, 'forbidden')
    end

    def record_not_found(_exception)
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(:not_found, 'record not found')
    end

    def active_model_errors(_exception)
      # For some reason on error the headers are not set
      # Setting it manually
      cors_set_access_control_headers
      set_response(:bad_request, exception.record.errors.full_messages)
    end

    def set_response(status, message, data = [])
      json = data.as_json
      data_name = 'data'
      data_name = if json["data"].any?
                    json["data"]["type"]
                  end if json.any?
      render status: status, json: {
        message: message,
        data_name => data
      }
    end

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'post, put, delete, get, patch'\
      ', options'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With,'\
        'Content-Type, Accept, Authorization, X-App-Version,'\
        'X-Device-Platform, X-Device-Name, X-Device-UUID, X-Total-Pages'
      headers['Access-Control-Expose-Headers'] = 'X-Total-Pages'
    end
  end
end
