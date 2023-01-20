module Api
  module V1
    class PaymentsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def payment
        begin
          unless payment_params.present?
            return display_error('All params are not present')
          end
          if payment_params.present?
            @payment = Payment.new(payment_params)
            if  @payment.save!
              render json: {api_status: true, locale: I18n.locale.to_s, payment: @payment}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @payment.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @payment.errors}
        end

      end

      private
      def payment_params
        params.permit( :name_of_card, :card_number, :expiring_date, :cvc, :subscription_id, :checkout_id, :user_id)
      end

      def user
        @user ||= current_user
      end

    end
  end
end
