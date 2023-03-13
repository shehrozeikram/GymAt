module Api
  module V1

class TrainerVideosController < Api::V1::ApiController

  skip_before_action :authenticate_user!
  def fetch_trainer_videos
    begin
      unless params[:trainer_id].present?
        return  display_error("Trainer ID is missing!")
      end
      if params[:trainer_id].present?
        @trainer = Trainer.find(params[:trainer_id])
        @trainer_videos = @trainer.trainer_videos
        return render json: display_error("Trainer Not  Present ")  unless @trainer.present?
      end

      if @trainer_videos == []
      return render json: {api_status: false, error: 'Trainer has no videos' }
      end

      if I18n.locale.to_s == "ar"
        @trainer_videos.description = @trainer.ar_description
        @trainer_videos.title = @trainer.ar_title
      end

      return render json: {api_status: true, locale: I18n.locale.to_s, trainer_videos: @trainer_videos }
    rescue => e
      return display_error("Something Went Wrong!")
    end
  end


end
  end
  end
