module Api
  module V1
    class BusinessesController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def fetch_business #For product search
        begin
          if params[:q].present?
            @business = Business.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:business_type]
            @business =Business.where(business_type: params[:business_type])
          else
            @business =Business.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @business.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, business: @business}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, business: @business}
        end
      end


      def filter_business #For product search
        begin
          unless params[:business_type].present?
            return  display_error("Business Type is missing!")
          end
          if params[:q].present?
            @business = Business.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif  params[:Suggested] == 'true'
            @business = Business.where(business_type: params[:business_type])
          elsif  params[:New] == 'true'
            @business = Business.where(business_type: params[:business_type]).order(created_at: :desc)
          elsif  params[:'Price (low to high)'] == 'true'
            @business =Business.where(business_type: params[:business_type]).order(price: :asc)
          elsif  params[:'Price (high to low)'] == 'true'
            @business =Business.where(business_type: params[:business_type]).order(price: :desc)
          else
            @business =Business.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @business.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, business: @business}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, business: @business}
        end
      end

      def show_business
        begin
          unless params[:id].present?
            return  display_error("Business ID is missing!")
          end
          if params[:id].present?
            @business = Business.find(params[:id])
            return display_error("Business Not  Present ")  unless @business.present?
          end

          if I18n.locale.to_s == "ar"
            @business.description = @business.ar_description
            @business.title = @business.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, business: @business }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      # subscription route
      def create_subscription
        begin
          unless subscription_params.present?
            return display_error('All params are not present')
          end
          if subscription_params.present?
            @subscription = Subscription.new(subscription_params)
            business = Business.where(id: params[:business_id]).last
            @subscription.business_type = business.business_type
            if  @subscription.save!
              render json: {api_status: true, locale: I18n.locale.to_s, subscription: @subscription}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @subscription.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @subscription.errors}
        end
      end

      def fetch_subscriptions
        begin
          unless params[:user_id].present?
            return display_error('Please provide user')
          end

          unless params[:business_type].present?
            return display_error('Please provide business type')
          end

            @user = User.where(id: params[:user_id]).last

          if @user.present?
            if  params[:business_type] == "Gym"
              @subscriptions = @user.subscriptions.where(business_type: "Gym")

            else params[:business_type] == "Health Club & Spa"
              @subscriptions = @user.subscriptions.where(business_type: "Health Club & Spa")

            end
            if @subscriptions.present?
              if I18n.locale.to_s == "ar"
                @subscriptions.each do |pr|
                  pr.description = pr.ar_description
                  pr.title = pr.ar_title
                end
              end
              render json: {api_status: true, locale: I18n.locale.to_s, subscriptions: @subscriptions}

            else
              render json: {api_status: false, locale: I18n.locale.to_s, error: 'This user doesnot have any subscription '}
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: 'This user doesnot exist '}
          end
          # render json: {api_status: true, locale: I18n.locale.to_s, subscriptions: @subscriptions}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @subscriptions.errors}
        end
      end


      def fetch_gym_subscriptions
        begin
          unless params[:business_type].present?
            return display_error('Business Type is not present')
          end
          if params[:user_id].present?
            @user = User.find(params[:user_id])
            @subscriptions = @user.subscriptions.where(business_type: "Gym")
          else
            @subscriptions = Subscription.all
          end

          if I18n.locale.to_s == "ar"
            @subscriptions.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, gym_subscriptions: @subscriptions.as_json( :include => [:user] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @subscriptions.errors}
        end
      end

      def fetch_health_club_subscriptions
        begin
          unless params[:business_type].present?
            return display_error('Business Type is not present')
          end
          if params[:user_id].present?
            @user = User.find(params[:user_id])
            @subscriptions = @user.subscriptions.where(business_type: "Health Club & Spa")
          else
            @subscriptions = Subscription.all
          end

          if I18n.locale.to_s == "ar"
            @subscriptions.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, health_club_subscriptions: @subscriptions.as_json( :include => [:user] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @subscriptions.errors}
        end
      end

      private
      def subscription_params
        params.permit( :full_name, :start_date, :subscription_type, :amount, :discount, :special_offer, :total_amount, :payment_id, :user_id, :business_id, :business_type)
      end

      private

      def user
        @user ||= current_user
      end

    end
  end
end
