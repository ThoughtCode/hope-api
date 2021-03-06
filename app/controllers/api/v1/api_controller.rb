module Api::V1
  class ApiController < ActionController::API
    include ActionController::MimeResponds
    include ActionController::HttpAuthentication::Token::ControllerMethods
    respond_to :json
    rescue_from Exception, with: :render_internal_server_error
    rescue_from ActiveRecord, with: :render_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :active_model_errors
    before_action :disable_access_by_tk, except: :contact

    def cors_default_options_check
      options = request.method == 'OPTIONS'
      headers['Access-Control-Max-Age'] = '1728000' if options
      render json: '' if options
    end

    def contact
      ContactMailer.contact_mail(contact_params).deliver
      set_response(200, 'Nos contactaremos contigo lo antes posible')
    end

    private
      def contact_params
        params.require(:contact).permit(:name, :celular, :email)
      end

    def current_user
      @user
    end

    def disable_access_by_tk
      authenticate_or_request_with_http_token do |token|
        find_by_token(token)
        unless @user
          set_response(401,
                       'HTTP Token: Acceso denegado.')
        end
        @user
      end
    rescue StandardError => e
      Rails.logger.error e
    end

    def find_by_token(token)
      @user = Agent.find_by(access_token: token) ||
              Customer.find_by(access_token: token)
    end

    def render_internal_server_error(exception)
      # For some reason on error the headers are not set
      # Setting it manually
      Rails.logger.error("ERROR api call: #{exception.message}")
      Rails.logger.error(exception.backtrace.join("\n"))
      set_response(500, exception.message)
    end

    def render_unauthorized
      # For some reason on error the headers are not set
      # Setting it manually
      set_response(401, 'Correo o contraseña invalidos.')
    end

    def render_forbidden
      # For some reason on error the headers are not set
      # Setting it manually
      set_response(403, 'Denegado')
    end

    def record_not_found(_exception)
      # For some reason on error the headers are not set
      # Setting it manually
      set_response(404, 'Registro no encontrado')
    end

    def active_model_errors(_exception)
      # For some reason on error the headers are not set
      # Setting it manually
      set_response(400, exception.record.errors.full_messages)
    end

    def set_response(status, message, data = [], total_pages = 0)
      json = data.as_json.any? ? data.as_json['data'] : data
      data_name = 'data'
      resource_name = if json.any?
                        json.is_a?(Array) ? json.first['type'] : json['type']
                      end
      data_name = resource_name if json.any?
      response.headers['X-Total-Pages'] = total_pages
      render status: status, json: {
        message: message,
        data_name => data
      }
    end
  end
end
