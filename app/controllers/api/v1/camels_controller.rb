module Api
  module V1
    class CamelsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


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

            @camels = Camel.where(camel_purpose: 'Rent')
          elsif params[:camel_purpose] == 'Buy'
            @camels = Camel.where(camel_purpose: 'Buy')
          else
            @camels = Camel.where(camel_purpose: 'Bid')
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
        params.permit(:name, :gender, :age, :awards, :price, :description, :camel_type, :owner_name, :camel_purpose, :rent_purpose)
      end


      def user
        @user ||= current_user
      end

    end
  end
end
