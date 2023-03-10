module Api
  module V1
    class ResturantsDishesController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List

      def filter_dishes #For product search
        begin
          if params[:q].present?
            @dishes = ResturantDish.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif  params[:Suggested] == 'true'
            @dishes = ResturantDish.all.order(title: :asc)
          elsif  params[:New] == 'true'
            @dishes = ResturantDish.order(created_at: :desc)
          elsif  params[:'Price (low to high)'] == 'true'
            @dishes =ResturantDish.order(price: :asc)
          elsif  params[:'Price (high to low)'] == 'true'
            @dishes =ResturantDish.order(price: :desc)
          else
            @dishes =ResturantDish.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @dishes.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, dishes: @dishes}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, dishes: @dishes}
        end
      end

      def fetch_dishes #For product search
        begin
          if params[:q].present?
            @dishes = ResturantDish.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:id]
            @dishes =ResturantDish.where(id: params[:id])
          else
            @dishes =ResturantDish.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @dishes.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, dishes: @dishes}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, dishes: @dishes}
        end
      end


      def show_dish
        begin
          unless params[:id].present?
            return  display_error("Dish ID is missing!")
          end
          if params[:id].present?
            @dish = Shop.find(params[:id])
            return display_error("Dish Not  Present ")  unless @dish.present?
          end

          if I18n.locale.to_s == "ar"
            @dish.description = @dish.ar_description
            @dish.title = @dish.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, dish: @dish  }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def best_seller
        begin
        @best_seller = ResturantDish.where("order_counter > ?", ResturantDish.minimum(:order_counter)).order(order_counter: :desc).limit(5)

        if I18n.locale.to_s == "ar"
          @dish.description = @dish.ar_description
          @dish.title = @dish.ar_title
        end

        render json: {api_status: true, locale: I18n.locale.to_s, best_seller: @best_seller}
      rescue => e
        return display_error("Something Went Wrong!")
      end
      end


      private

      def user
        @user ||= current_user
      end

    end
  end
end
