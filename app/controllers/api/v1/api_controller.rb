module Api
  module V1
    class ApiController < ActionController::API 
      include ActionController::MimeResponds
      include ActionController::HttpAuthentication::Token::ControllerMethods
      #include ApiAuthenticable
      respond_to :json
      
      rescue_from Exception, with: :render_internal_server_error
      rescue_from ActiveRecord, with: :render_internal_server_error
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :active_model_errors
      
      before_action :cors_set_access_control_headers
      before_action :restrict_access_by_token , except: [:cors_default_options_check, :ping]

      def cors_default_options_check
        if request.method == 'OPTIONS'
          headers['Access-Control-Max-Age'] = '1728000'
          render text: '', content_type: 'text/plain'
        end
      end

      def ping
        head :ok
      end

      private

      def restrict_access_by_token
        authenticate_or_request_with_http_token do |token|
          @current_user = Agent.find_by(access_token: token) || Customer.find_by(access_token: token)
          render :json => {:error => "HTTP Token: Access denied."}, :status => :unauthorized  unless @current_user
          @current_user
        end
        rescue Exception => e 
          Rails.logger.error e
      end

      def render_internal_server_error(exception)
        # For some reason on error the headers are not set
        # Setting it manually
        cors_set_access_control_headers
        Rails.logger.error("ERROR api call: #{exception.message}")
        Rails.logger.error(exception.backtrace.join("\n"))
        render json: { message: exception.message}, status: :internal_server_error
      end

      # TODO this function must be moved/implemented in a yet-to-exist SessionsAPIController
      #   (or whatever its name will be - its semantics will involve logging users in/out,
      #   creating/revoking tokens in the process).

      def render_unauthorized
        # For some reason on error the headers are not set
        # Setting it manually
        cors_set_access_control_headers
        render json: { message: 'email/password mismatch' }, status: :unauthorized
      end

      def render_forbidden
        # For some reason on error the headers are not set
        # Setting it manually
        cors_set_access_control_headers
        render json: { message: 'forbidden' }, status: :forbidden
      end

      def record_not_found(exception)
        # For some reason on error the headers are not set
        # Setting it manually
        cors_set_access_control_headers
        render json: { message: 'record not found' }, status: :not_found
      end

      def active_model_errors(exception)
        # For some reason on error the headers are not set
        # Setting it manually
        cors_set_access_control_headers
        render json: { full_messages: exception.record.errors.full_messages }, status: :bad_request 
      end

      def render_success_message(message = 'operation successful')
        render json: { message: message }, status: :ok
      end

      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, PATCH'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-App-Version, X-Device-Platform, X-Device-Name, X-Device-UUID, X-Total-Pages'
        headers['Access-Control-Expose-Headers'] = 'X-Total-Pages'
      end
    end
  end
end
