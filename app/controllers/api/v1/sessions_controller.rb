module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      include ExceptionHandler
      include ActAsApiRequest
      include Localizable
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!, only: :destroy

      def destroy
        # remove auth instance variables so that after_action does not run
        user = remove_instance_variable(:@resource) if @resource
        client = @token.client
        @token.clear!

        if user && client && user.tokens[client]
          user.tokens.delete(client)
          user.save!

          if DeviseTokenAuth.cookie_enabled
            # If a cookie is set with a domain specified then it must be deleted with that domain specified
            # See https://api.rubyonrails.org/classes/ActionDispatch/Cookies.html
            cookies.delete(DeviseTokenAuth.cookie_name, domain: DeviseTokenAuth.cookie_attributes[:domain])
          end

          yield user if block_given?

          render_create_success_msg
        else
          render_destroy_error_msg
        end
      end

      def render_destroy_error_msg
        render json: {api_status: false, erorr: "failed" }, status: 422
      end

      def render_create_success_msg
        render json: {api_status: true, success: true }, status: 200
      end

      private

      def resource_params
        params[:email] = params[:contact_number].to_s + "@myappointment.com"
        params.permit(:email, :password)
      end

      def render_create_success
        render json: {api_status: true, success: true }, status: 200
      end

      def render_destroy_success
        head(:no_content)
      end

      def render_create_error_bad_credentials
        render_errors(I18n.t('errors.authentication.invalid_credentials'), :forbidden)
      end
    end
  end
end
