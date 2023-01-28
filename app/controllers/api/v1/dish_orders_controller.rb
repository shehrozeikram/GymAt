module Api
  module V1
    class DishOrdersController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Create Order

      def create_order
        begin
          unless dish_order_params.present?
            return display_error('All params are not present')
          end
          if dish_order_params.present?
            @dish_order = DishOrder.new(dish_order_params)

            @order = @dish_order.resturant_dish
            @order.order_counter += 1
            @order.save!
            if  @dish_order.save!
              render json: {api_status: true, locale: I18n.locale.to_s, dish_order: @dish_order.as_json( :include => [:resturant_dish] ) }
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @dish_order.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @dish_order.errors}
        end
      end


      def order_again
        begin
          unless params[:user_id].present?
            return  display_error("Order ID is missing!")
          end
          if params[:user_id].present?
            @user = User.find(params[:user_id])
            @last_5_orders = @user.dish_orders.last(5).each do |document|
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

          return render json: {api_status: true, locale: I18n.locale.to_s, order_again: @order_again.as_json( :include => [:resturant_dish] )}
        rescue => e
          render json: {api_status: false, error: 'SomeThing went wrong'}
        end
      end


      private

      def dish_order_params
        params.permit(:self_pickup, :delivery, :discount, :user_id, :resturant_dish_id, :payment_id, :longitude, :latitude)
      end


    end
  end
end
