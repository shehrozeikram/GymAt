module Api
  module V1
    class TrainingProgramsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def fetch_training_programs #For product search
        begin
          if params[:q].present?
            @training_programs = TrainingProgram.where("LOWER(days) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:trainer_id]
            @training_programs = TrainingProgram.where(trainer_id:params[:trainer_id])
          else
            @training_programs =TrainingProgram.all.order(days: :asc)
          end

          if I18n.locale.to_s == "ar"
            @training_programs.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, training_programs: @training_programs}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, training_programs: @training_programs}
        end
      end


      def show_training_program
        begin
          unless params[:id].present?
            return  display_error("Training_program ID is missing!")
          end
          if params[:id].present?
            @training_program = TrainingProgram.find(params[:id])
            return display_error("Training_program Not  Present ")  unless @training_program.present?
          end

          if I18n.locale.to_s == "ar"
            @training_program.description = @training_program.ar_description
            @training_program.title = @training_program.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, training_program: @training_program.as_json( :include => [:user] ) }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      # def create_trainer_subscription
      #   begin
      #     unless trainer_subscription_params.present?
      #       return display_error('All params are not present')
      #     end
      #     if trainer_subscription_params.present?
      #       @trainer_subscription = TrainerSubscription.new(trainer_subscription_params)
      #       @trainer = @trainer_subscription.trainer
      #       @trainer_subscriber = @trainer_subscription.trainer
      #       @trainer_subscriber.subscribers += 1
      #       @trainer_subscriber.save!
      #       if  @trainer_subscription.save!
      #         render json: {api_status: true, locale: I18n.locale.to_s, trainer_subscription: @trainer_subscription, trainer: @trainer }
      #       end
      #     else
      #       render json: {api_status: false, locale: I18n.locale.to_s, error: @trainer_subscription.errors}
      #     end
      #   rescue => e
      #     render json: {api_status: false, locale: I18n.locale.to_s, error: @trainer_subscription.errors}
      #   end
      # end


      def fetch_activities #For product search
        begin
          if params[:q].present?
            @activities = Activity.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
          elsif params[:id]
            @activities = Activity.where(day: params[:day])
          else
            @activities =Activity.all.order(title: :asc)
          end

          if I18n.locale.to_s == "ar"
            @activities.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true, locale: I18n.locale.to_s, activities: @activities}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, activities: @activities}
        end
      end


      def show_activity
        begin
          unless params[:id].present?
            return  display_error("Activity ID is missing!")
          end
          if params[:id].present?
            @activity = Activity.find(params[:id])
            return display_error("Activity Not  Present ")  unless @activity.present?
          end

          if I18n.locale.to_s == "ar"
            @activity.description = @activity.ar_description
            @activity.title = @activity.ar_title
          end

          # @service = @service.to_json

          return render json: {api_status: true, locale: I18n.locale.to_s, activity: @activity.as_json( :include => [:trainer] ) }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      private

      # def trainer_subscription_params
      #   params.permit( :start_date, :end_date, :time, :trainer_id, :user_id)
      # end

      # def trainer_params
      #   params.permit( :name, :trainer_type, :subscribers, :rating, avatar: [], attachments: [])
      # end

      def user
        @user ||= current_user
      end

    end
  end
end
