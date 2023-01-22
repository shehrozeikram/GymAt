module Api
  module V1
    class OrdersController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Create Order

      def create_order
        begin
          unless order_params.present?
            return display_error('All params are not present')
          end
          if order_params.present?
            @order = Order.new(order_params)
            # if @order.save_locations == true
            #   @order.user.save_location_latitude = @order.latitude
            #   @order.user.save_location_longitude = @order.longitude
            # end
            if  @order.save!
              render json: {api_status: true, locale: I18n.locale.to_s, order: @order}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @order.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @order.errors}
        end
      end


      def order_again
        begin
          unless params[:user_id].present?
            return  display_error("Order ID is missing!")
          end
          if params[:user_id].present?
            @user = User.find(params[:user_id])
            @last_5_orders = @user.orders.last(5).each do |document|
              document.resturant_dish
            end
            @order_again = @last_5_orders
            return display_error("Order Not  Present ")  unless @order_again.present?
          end

          if I18n.locale.to_s == "ar"
            @order_again.description = @order_again.ar_description
            @order_again.title = @order_again.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, order_again: @order_again }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end



      private

      def order_params
        params.permit(:self_pickup, :delivery, :discount, :user_id, :resturant_dish_id, :payment_id, :longitude, :latitude)
      end


    end
  end
end
