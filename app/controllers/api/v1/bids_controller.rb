module Api
  module V1
    class BidsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List


      def create_bid
        @bid = Bid.new(bid_params)
        if !@bid.bid_amount
          render json: {api_status: false,  error: 'Bid amount can not be blank'}
        else
          if @bid.save
            if I18n.locale.to_s == "ar"
              @bid.description = @bid.ar_description
              @bid.title = @bid.ar_title
            end
            render json: {api_status: true, locale: I18n.locale.to_s, bid: @bid}
          else
            render json: {api_status: false, locale: I18n.locale.to_s, error: @bid.errors}
          end
        end
      end



      private

      def bid_params
        params.permit(:bid_amount, :user_id, :camel_id)
      end




    end
  end
end
