module Api
  module V1
    class ShopsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def fetch_shops #For product search
        begin
          if params[:q].present?
            @shops = Shop.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:shop_type]
            @shops =Shop.where(shop_type: params[:shop_type])
          else
            @shops =Shop.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @shops.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, shops: @shops}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, shops: @shops}
        end
      end


      def show_shop
        begin
          unless params[:id].present?
            return  display_error("Shop ID is missing!")
          end
          if params[:id].present?
            @shop = Shop.find(params[:id])
            return display_error("Shop Not  Present ")  unless @shop.present?
          end

          if I18n.locale.to_s == "ar"
            @shop.description = @shop.ar_description
            @shop.title = @shop.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, shop: @shop }
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
