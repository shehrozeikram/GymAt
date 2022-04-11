module Api
  module V1
    class ShoppingCartsController < Api::V1::ApiController
      helper_method :user

      #Search List
      # get '/create', to: 'shopping_carts#create'
      # get '/my_carts', to: 'shopping_carts#my_carts'
      # get '/delete', to: 'shopping_carts#delete_cart'
      # get '/update', to: 'shopping_carts#update'

      # Parameters: {"product_id"=>8, "stock"=>1, "delivery_date"=>"21-03-2022",
      #              "delivery_time"=>"2022-03-21T16:51:49.360Z",
      #              "buy_for_myselft"=>true, "buy_for_someone"=>false,
      #              "shopping_cart"=>{"product_id"=>8, "stock"=>1}}

      def create #For product search
        begin
        if params[:product_id].present? && params[:stock].present?
          cart =  ShoppingCart.new(product_id:  params[:product_id] , stock: params[:stock] , user_id: user.id,
                                   delivery_date: params[:delivery_date],
                                   delivery_time: params[:delivery_time],
                                   buy_for_myself: params[:buy_for_myself],
                                   buy_for_someone: params[:buy_for_someone])
          if cart.save!
            return display_success("Cart Successfully created")
          end
        else
          return display_error("Product ID OR Stock Quantity Missing!")
        end

        rescue => e
          return display_error(e.inspect)
        end
      end

      def update #Update shopping cart
        begin
          if  params[:cart_id].present? && params[:stock]
            cart =  ShoppingCart.find(params[:cart_id])
            if cart.present?
              cart.stock = params[:stock]
              if cart.save
                return display_success("Cart Successfully updated!")
              end
            else
              return display_error("Invalid Cart Id")
            end
          else
            return display_error("stock OR cart_id Missing!")
          end
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def my_carts  #Fetch all current user carts
        begin
          my_carts = user.shopping_carts.where(active: true)
          cart_data =  []
          my_carts.each do |cart|

            product = cart.product

            if I18n.locale.to_s == "ar"
              product.description = product.ar_description
              product.title = product.ar_title
            end

            cart_data << { product: product, quantity: cart.stock, cart_id: cart.id,
                           delivery_date: cart.delivery_date,
                           delivery_time: cart.delivery_time,
                           buy_for_myself: cart.buy_for_myself,
                           buy_for_someone: cart.buy_for_someone }
          end
          render json: {shopping_carts: cart_data }
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def delete #delete current user specific cart
        begin
          if  params[:cart_id].present?
            cart = user.shopping_carts.where(id: params[:cart_id]).last
            if cart.present?
              cart.active  = false
              if  cart.save
                return display_success("Cart Deleted")
              end
            else
              return display_error("Cart id invalid!")
            end
          else
            return display_error("Cart Id missing!")
          end
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      private
        def display_error(msg)
           render json: {api_status: false, locale: I18n.locale.to_s, error: msg}
        end

        def user
        @user ||= current_user
      end

    end
  end
end
