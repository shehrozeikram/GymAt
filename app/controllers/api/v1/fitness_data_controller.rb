module Api
  module V1

class FitnessDataController < Api::V1::ApiController
  skip_before_action :authenticate_user!

  def create_fitness_data
    begin
      unless params[:activity_id].present?
        return display_error('Activity is not present')
      end
      if params[:activity_id].present?
        @activity = Activity.where(id: params[:activity_id]).last
        @user = User.find(params[:user_id])
        @fitness_data = @user.fitness_data.new(fitness_data_params)
        @fitness_data.exercise = @activity.minutes
        @fitness_data.activity.calories = @activity.calories

        if params[:burger] == 'true'
          @fitness_data.burger = true
          @fitness_data.burger_calories = 295
        end

        if params[:coke] == 'true'
          @fitness_data.coke = true
          @fitness_data.coke_calories = 97
        end

        if params[:water] == 'true'
          @fitness_data.water = true
          @fitness_data.water_calories = 10
        end

        if params[:walking].present?
          if @fitness_data.walking < 10
            @fitness_data.walking_calories = 52
          elsif @fitness_data.walking >= 10 && @fitness_data.walking < 20
            @fitness_data.walking_calories = 105
          elsif @fitness_data.walking >= 20 && @fitness_data.walking < 30
            @fitness_data.walking_calories = 157
          elsif @fitness_data.walking >= 30 && @fitness_data.walking < 40
            @fitness_data.walking_calories = 209
          elsif @fitness_data.walking >= 40 && @fitness_data.walking < 50
            @fitness_data.walking_calories = 261
          elsif @fitness_data.walking >= 50 && @fitness_data.walking < 60
            @fitness_data.walking_calories = 313
          elsif @fitness_data.walking >= 60 && @fitness_data.walking < 70
            @fitness_data.walking_calories = 365
          elsif @fitness_data.walking >= 70 && @fitness_data.walking < 80
            @fitness_data.walking_calories = 417
          elsif @fitness_data.walking >= 80 && @fitness_data.walking < 90
            @fitness_data.walking_calories = 469
          elsif @fitness_data.walking >= 90 && @fitness_data.walking < 100
            @fitness_data.walking_calories = 521

          elsif @fitness_data.walking >= 100 && @fitness_data.walking < 110
            @fitness_data.walking_calories = 573
          elsif @fitness_data.walking >= 110 && @fitness_data.walking < 120
            @fitness_data.walking_calories = 625
          elsif @fitness_data.walking >= 120 && @fitness_data.walking < 130
            @fitness_data.walking_calories = 677
          elsif @fitness_data.walking >= 130 && @fitness_data.walking < 140
            @fitness_data.walking_calories = 729
          elsif @fitness_data.walking >= 140 && @fitness_data.walking < 150
            @fitness_data.walking_calories = 781

          elsif @fitness_data.walking >= 150 && @fitness_data.walking < 160
            @fitness_data.walking_calories = 833
          elsif @fitness_data.walking >= 160 && @fitness_data.walking < 170
            @fitness_data.walking_calories = 885
          elsif @fitness_data.walking >= 170 && @fitness_data.walking < 180
            @fitness_data.walking_calories = 937
          elsif @fitness_data.walking >= 180 && @fitness_data.walking < 190
            @fitness_data.walking_calories = 989
          elsif @fitness_data.walking >= 190 && @fitness_data.walking < 200
            @fitness_data.walking_calories = 1041
          else
            @fitness_data.walking_calories = 1100
          end
        end

        if params[:running].present?
          if @fitness_data.running < 10
            @fitness_data.running_calories = 80
          elsif @fitness_data.running >= 10 && @fitness_data.running < 20
            @fitness_data.running_calories = 160
          elsif @fitness_data.running >= 20 && @fitness_data.running < 30
            @fitness_data.running_calories = 240
          elsif @fitness_data.running >= 30 && @fitness_data.running < 40
            @fitness_data.running_calories = 320
          elsif @fitness_data.running >= 40 && @fitness_data.running < 50
            @fitness_data.running_calories = 400
          elsif @fitness_data.running >= 50 && @fitness_data.running < 60
            @fitness_data.running_calories = 480
          elsif @fitness_data.running >= 60 && @fitness_data.running < 70
            @fitness_data.running_calories = 560
          elsif @fitness_data.running >= 70 && @fitness_data.running < 80
            @fitness_data.running_calories = 640
          elsif @fitness_data.running >= 80 && @fitness_data.running < 90
            @fitness_data.running_calories = 720
          elsif @fitness_data.running >= 90 && @fitness_data.running < 100
            @fitness_data.running_calories = 800

          elsif @fitness_data.running >= 100 && @fitness_data.running < 110
            @fitness_data.running_calories = 880
          elsif @fitness_data.running >= 110 && @fitness_data.running < 120
            @fitness_data.running_calories = 960
          elsif @fitness_data.running >= 120 && @fitness_data.running < 130
            @fitness_data.running_calories = 1040
          elsif @fitness_data.running >= 130 && @fitness_data.running < 140
            @fitness_data.running_calories = 1120
          elsif @fitness_data.running >= 140 && @fitness_data.running < 150
            @fitness_data.running_calories = 1200

          elsif @fitness_data.running >= 150 && @fitness_data.running < 160
            @fitness_data.running_calories = 1280
          elsif @fitness_data.running >= 160 && @fitness_data.running < 170
            @fitness_data.running_calories = 1360
          elsif @fitness_data.running >= 170 && @fitness_data.running < 180
            @fitness_data.running_calories = 1440
          elsif @fitness_data.running >= 180 && @fitness_data.running < 190
            @fitness_data.running_calories = 1520
          elsif @fitness_data.running >= 190 && @fitness_data.running < 200
            @fitness_data.running_calories = 1600
          else
            @fitness_data.running_calories = 1680
          end
        end


        if params[:water] == 'true'
          @fitness_data.water = true
          @fitness_data.water_calories = 10
        end

        @fitness_data.total_hours = @fitness_data.exercise + @fitness_data.running + @fitness_data.walking
        @fitness_data.exercise_calories = @activity.calories
        @fitness_data.calories_gain = @fitness_data.burger_calories + @fitness_data.coke_calories + @fitness_data.water_calories
        @fitness_data.calories_burn = @fitness_data.walking_calories + @fitness_data.exercise_calories + @fitness_data.running_calories
        @fitness_data.steps = 2000
        @fitness_data.blood_pressure = params[:blood_pressure] unless params[:blood_pressure].present?
        @fitness_data.save!
        if  @fitness_data.save!
          render json: {api_status: true, locale: I18n.locale.to_s, fitness_data: @fitness_data.as_json( :include => [:user] ) }
        end
      else
        render json: {api_status: false, locale: I18n.locale.to_s, error: @fitness_data.errors}
      end
    rescue => e
      render json: {api_status: false, locale: I18n.locale.to_s, error: @fitness_data.errors}
    end
    end



  def fetch_fitness_data
    begin
      if params[:user_id].present?
        @user = User.find(params[:user_id])
        @fitness_data = FitnessDatum.where(user_id: params[:user_id])
      else
        @fitness_data = FitnessDatum.all
      end

      if I18n.locale.to_s == "ar"
        @fitness_data.each do |pr|
          pr.description = pr.ar_description
          pr.title = pr.ar_title
        end
      end

      render json: {api_status: true, locale: I18n.locale.to_s, fitness_data: @fitness_data.as_json( :include => [:user] )}
    rescue => e
      render json: {api_status: false, locale: I18n.locale.to_s, error: @fitness_data.errors}
    end
  end

  private

  def fitness_data_params
    params.permit(:burger, :coke, :water, :activity_id, :date, :calories_gain, :calories_burn, :walking, :exercise, :steps, :running, :total_hours, :blood_pressure, :user_id)
  end



end
end
end
