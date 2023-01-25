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

          return render json: {api_status: true, locale: I18n.locale.to_s, shop: @shop, include:  ['users']  }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      def checkout
        begin
          unless checkout_params.present?
            return display_error('All params are not present')
          end
          if checkout_params.present?
            @checkout = Checkout.new(checkout_params)
            if  @checkout.save!
              render json: {api_status: true, locale: I18n.locale.to_s, checkout: @checkout}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @checkout.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @checkout.errors}
        end

      end

      def fetch_related_products #For product search
        begin
          if params[:q].present?
            @related_products = RelatedShop.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:shop_id]
            @related_products =RelatedShop.where(shop_id: params[:shop_id])
          else
            @related_products =RelatedShop.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @related_products.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, related_products: @related_products}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, related_products: @related_products.errors}
        end
      end


      private
      def checkout_params
        params.permit( :title, :free_delivery, :price, :quantity, :sub_total, :shipping_fee, :discount, :total, :user_id, :shop_id, :payment_id, attachments: [])
        end

      def user
        @user ||= current_user
      end

    end
  end
end
