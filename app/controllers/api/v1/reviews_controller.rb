module Api
  module V1

class ReviewsController < ApplicationController

  def create_review
    begin
      unless review_params.present?
        return display_error('All params are not present')
      end
      if review_params.present?
        @review = Review.new(review_params)
        if  @review.save!
          render json: {api_status: true, locale: I18n.locale.to_s, review: @review}
        end
      else
        render json: {api_status: false, locale: I18n.locale.to_s, error: @review.errors}
      end
    rescue => e
      render json: {api_status: false, locale: I18n.locale.to_s, error: @review.errors}
    end
  end

  def show_reviews
    begin
      unless params[:business_id].present?
        return  display_error("Business ID is missing!")
      end
      if params[:business_id].present?
        @review =Review.where(business_id: params[:business_id])
      end

      if I18n.locale.to_s == "ar"
        @review.description = @review.ar_description
        @review.title = @review.ar_title
      end

      # @service = @service.to_json

      return render json: {api_status: true, locale: I18n.locale.to_s, review: @review }
    rescue => e
      return display_error("Something Went Wrong!")
    end
  end

  private

  def review_params
    params.permit( :body, :user_id, :business_id)
  end

end

  end
  end