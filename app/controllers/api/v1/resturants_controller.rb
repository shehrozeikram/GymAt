module Api
  module V1
    class ResturantsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def fetch_resturants #For product search
        begin
          if params[:q].present?
            @resturants = Resturant.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:id]
            @resturants =Resturant.where(id: params[:id])
          else
            @resturants =Resturant.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @resturants.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, resturants: @resturants}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, resturants: @resturants}
        end
      end


      def show_resturant
        begin
          unless params[:id].present?
            return  display_error("Resturant ID is missing!")
          end
          if params[:id].present?
            @resturant = Resturant.find(params[:id])
            return display_error("Resturant Not  Present ")  unless @resturant.present?
          end

          if I18n.locale.to_s == "ar"
            @resturant.description = @resturant.ar_description
            @resturant.title = @resturant.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, resturant: @resturant }
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
