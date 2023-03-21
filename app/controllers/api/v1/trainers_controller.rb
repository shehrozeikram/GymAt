module Api
  module V1
    class TrainersController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def fetch_trainers #For product search
        begin
          if params[:q].present?
            @trainers = Trainer.where("LOWER(name) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:trainer_type]
            @trainers = Trainer.where(trainer_type: params[:trainer_type])
          else
            @trainers =Trainer.all.order(name: :asc)
          end

          if I18n.locale.to_s == "ar"
            @trainers.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, trainers: @trainers}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, trainers: @trainers}
        end
      end


      def fetch_trainer_booking #For product search
        begin

          unless params[:trainer_id] && params[:start_date].present?
            return display_error('All params are not present')
          end

          if params[:trainer_id] && params[:start_date].present?
            @trainer_booking = TrainerSubscription.where(id: params[:trainer_id]).where(id: params[:trainer_id]).all.order(start_date: :asc)
          else
            @trainer_booking = TrainerSubscription.all.order(start_date: :asc)
          end

          if I18n.locale.to_s == "ar"
            @trainer_booking.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, trainer_booking: @trainer_booking.as_json( :include => [:trainer] )}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: 'internal error'}
        end
      end

      def show_trainer
        begin
          unless params[:id].present?
            return  display_error("Trainer ID is missing!")
          end
          if params[:id].present?
            @trainer = Trainer.find(params[:id])
            return display_error("Trainer Not  Present ")  unless @trainer.present?
          end

          if I18n.locale.to_s == "ar"
            @trainer.description = @trainer.ar_description
            @trainer.title = @trainer.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, trainer: @trainer }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      def create_trainer_subscription
        begin
          unless trainer_subscription_params.present?
            return display_error('All params are not present')
          end
          if trainer_subscription_params.present?
            @trainer_subscription = TrainerSubscription.new(trainer_subscription_params)
            @trainer = @trainer_subscription.trainer
            @trainer_subscriber = @trainer_subscription.trainer
            @trainer_subscriber.subscribers += 1
            @trainer_subscriber.save!
            if  @trainer_subscription.save!
              render json: {api_status: true, locale: I18n.locale.to_s, trainer_subscription: @trainer_subscription, trainer: @trainer }
            end
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @trainer_subscription.errors}
          end
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, error: @trainer_subscription.errors}
        end
      end



      private

      def trainer_subscription_params
        params.permit( :start_date, :end_date, :time, :trainer_id, :user_id)
      end

      def trainer_params
        params.permit( :name, :trainer_type, :subscribers, :rating, avatar: [], attachments: [])
      end

      def user
        @user ||= current_user
      end

    end
  end
end
