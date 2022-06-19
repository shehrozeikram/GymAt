module Api
  module V1
    class CamelsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List

      def search_camels
        begin
          if params[:q].present?
            @camels = Camel.where("LOWER(name) LIKE LOWER(?)", "%#{params[:q]}%").page params[:page]
          elsif params[:tags]
            @camels =Camel.tagged_with(params[:tags]).order(name: :asc).page params[:page]
          else
            @camels =Camel.all.order(name: :asc).page params[:page]
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels: @camels.uniq}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, camels: @camels.uniq}
        end
      end

      def create_camel
        unless camel_params.present?
          return display_error('All params are not present')
        end
        if camel_params.present?
          @camel = Camel.new(camel_params)
          @camel.save

          if I18n.locale.to_s == "ar"
            @camel.description = @camel.ar_description
            @camel.title = @camel.ar_title
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camel: @camel}
        end
        render json: {api_status: false, locale: I18n.locale.to_s, error: @camel.errors}

      end


      def fetch_camels #For Camels search
        begin
          unless params[:tags].present?
            return  display_error("Camel Tag is missing or it is wrong!")
          end

          if params[:q].present?
            @camels = Camel.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:tags]
            @camels = Camel.tagged_with(params[:tags]).order(name: :asc)
          else
            @camels = Camel.all.order(name: :asc)
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels: @camels.uniq}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def show_camel
        begin
          unless params[:id].present?
            return  display_error("Camel ID is missing!")
          end
          if params[:id].present?
            @camel = Camel.find(params[:id])
            return display_error("Camel Not  Present ")  unless @camel.present?
          end

          if I18n.locale.to_s == "ar"
            @camel.description = @camel.ar_description
            @camel.title = @camel.ar_title
          end

          camel =  @camel
          return render json: {api_status: true, locale: I18n.locale.to_s, camel: camel}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end



      def fetch_camels_with_purpose
        begin
          unless params[:tags].present?
            return  display_error("Camel Tag is missing or it is wrong!")
          end

          unless params[:camel_purpose].present?
            return display_error("Camel purpose is missing or it is wrong!")
          end

          if params[:camel_purpose] == 'Rent'

            @camels_for_competition = Camel.where(rent_purpose: 'For Competition')
            @camels_for_rides = Camel.where(rent_purpose: 'For Rides')


          elsif params[:camel_purpose] == 'Buy'
            @camels_for_buy = Camel.where(camel_purpose: 'Buy')
          else
            @camels_almost_over = Camel.where(bid_type: 'Almost Over')
            @camels_recently_added = Camel.where(bid_type: 'Recently Added')
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels_for_competition: @camels_for_competition, camels_for_rides: @camels_for_rides, camels_for_buy: @camels_for_buy, camels_almost_over: @camels_almost_over,camels_recently_added: @camels_recently_added }
        rescue => e
          return display_error("Something Went Wrong!")
        end
        end


      def fetch_camels_with_prupose_bid_almost_over
        begin
          unless params[:tags].present?
            return  display_error("Camel Tag is missing or it is wrong!")
          end

          unless params[:camel_purpose].present? && params[:camel_purpose] == 'Bid'
            return display_error("Camel purpose is missing or it is wrong!")
          end

          unless params[:bid_type].present?
            return display_error("Bid type is missing or it is wrong!")
          end

          if params[:bid_type] == 'Almost Over'
            @camels_almost_over = Camel.where(bid_type: 'Almost Over')
            @camels_recently_added = Camel.where(bid_type: 'Recently Added')
          else
            render json: {api_status: false, locale: I18n.locale.to_s, camels: @camels.errors}
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels_almost_over: @camels_almost_over, camels_recently_added: @camels_recently_added}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def fetch_camels_with_prupose_bid_recently_added
        begin
          unless params[:tags].present?
            return  display_error("Camel Tag is missing or it is wrong!")
          end

          unless params[:camel_purpose].present? && params[:camel_purpose] == 'Bid'
            return display_error("Camel purpose is missing or it is wrong!")
          end

          unless params[:bid_type].present?
            return display_error("Bid type is missing or it is wrong!")
          end

          if params[:bid_type] == 'Recently Added'
            @camels = Camel.where(bid_type: 'Recently Added')
          else
            render json: {api_status: false, locale: I18n.locale.to_s, camels: @camels.errors}
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels: @camels}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def fetch_camels_with_prupose_rent_for_competition
        begin
          unless params[:tags].present?
            return  display_error("Camel Tag is missing or it is wrong!")
          end

          unless params[:camel_purpose].present? && params[:camel_purpose] == 'Rent'
            return display_error("Camel purpose is missing or it is wrong!")
          end

          unless params[:rent_purpose].present?
            return display_error("Rent purpose is missing or it is wrong!")
          end

          if params[:rent_purpose] == 'For Competition'
            @camels = Camel.where(rent_purpose: 'For Competition')
          else
            render json: {api_status: false, locale: I18n.locale.to_s, camels: @camels.errors}
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels: @camels}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def fetch_camels_with_prupose_rent_for_rides
        begin
          unless params[:tags].present?
            return  display_error("Camel Tag is missing or it is wrong!")
          end

          unless params[:camel_purpose].present? && params[:camel_purpose] == 'Rent'
            return display_error("Camel purpose is missing or it is wrong!")
          end

          unless params[:rent_purpose].present?
            return display_error("Rent purpose is missing or it is wrong!")
          end

          if params[:rent_purpose] == 'For Rides'
            @camels = Camel.where(rent_purpose: 'For Rides')
          else
            render json: {api_status: false, locale: I18n.locale.to_s, camels: @camels.errors}
          end

          if I18n.locale.to_s == "ar"
            @camels.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, camels: @camels}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      private

      def camel_params
        params.permit(:name, :gender, :age, :awards, :price, :description, :camel_type, :owner_name, :camel_purpose, :rent_purpose, :bid_type)
      end


      def user
        @user ||= current_user
      end

    end
  end
end
