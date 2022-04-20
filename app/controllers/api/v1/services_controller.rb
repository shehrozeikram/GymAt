module Api
  module V1
    class ServicesController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List

      def fetch_services #For product search
        begin
        if params[:q].present?
          @services = Service.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page params[:page]
        elsif params[:tags]
          @services =Service.tagged_with(params[:tags]).order(title: :asc).page params[:page]
        else
          @services =Service.all.order(title: :asc).page params[:page]
        end

        if I18n.locale.to_s == "ar"
          @services.each do |pr|
            pr.description = pr.ar_description
            pr.title = pr.ar_title
          end
        end

        render json: {api_status: true, locale: I18n.locale.to_s, services: @services.uniq}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, services: @services.uniq}
        end
      end


      def time_slots
        if params[:service_provider_id].present? && params[:day].present?
          begin

        service_availability = ServiceAvailability.where( service_provider_id: params[:service_provider_id], day: params[:day].split(/\W+/).first.capitalize).last
          total_minutes = (service_availability.end_time.strftime('%R').to_time - service_availability.start_time.strftime('%R').to_time) / 60
           time_slots = []
           Rails.logger.info " ti####################{total_minutes}#########################"
          (0..total_minutes).step(30) do |minutes|
            Rails.logger.info " ----------------------------------------------"

            time = service_availability.start_time.strftime('%R').to_time + minutes*60
            Rails.logger.info " time slot time slots#{time.strftime('%H:%M %p')}"

            time_slots << time.strftime('%H:%M %p')
          end
          render  json: {api_status: true, locale: I18n.locale.to_s, time_slots: time_slots}
          rescue => e
            render  json: {api_status: false, locale: I18n.locale.to_s, error: "Required Params Missing or something went wrong!"}
          end
        else
          render  json: {api_status: false, locale: I18n.locale.to_s, error: "Required Params Missing!"}

        end
      end


      def show_service
        begin
           unless params[:id].present?
             return  display_error("Service ID is missing!")
           end
          if params[:id].present?
            @service = Service.find(params[:id])
            return display_error("Service Not  Present ")  unless @service.present?
          end

           if I18n.locale.to_s == "ar"
             @service.description = @service.ar_description
             @service.title = @service.ar_title
           end

           days = ServiceAvailability.availability_days(@service.service_provider_id)
           available_slots = (Date.today..Date.today.next_month).select {""}.map!{|f|
             [f.strftime("%A"), f.strftime("%A %F")]}.map{|k,v| k.in?(days) ? v : ""}.reject(&:blank?)
           return render json: {api_status: true, locale: I18n.locale.to_s, service: @service, available_dates: available_slots}
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
