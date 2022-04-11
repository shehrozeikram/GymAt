module Api
  module V1
    class ProductsController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List

      def fetch_product #For product search
        begin
        if params[:q].present?
          @products = Product.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page params[:page]
        else
          @products = Product.all.order(title: :asc).page params[:page]
        end

        if I18n.locale.to_s == "ar"
          @products.each do |pr|
            pr.description = pr.ar_description
            pr.title = pr.ar_title
          end
        end

        render json: {api_status: true, locale: I18n.locale.to_s, products: @products}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, products: @products}
        end
      end


      def fetch_categories #For Category search
        begin
          if params[:q].present?
            @category = Category.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page params[:page]
          else
            @category = Category.all.order(title: :asc).page params[:page]
          end

          if I18n.locale.to_s == "ar"
            @category.each do |pr|
              pr.description = pr.ar_description
              pr.title = pr.ar_title
            end
          end

          render json: {api_status: true,locale: I18n.locale.to_s, category: @category}
        rescue => e
          render json: {api_status: false,locale: I18n.locale.to_s, category: @category}
        end
      end

      def show_product
        begin
           unless params[:id].present?
             return  display_error("Product ID is missing!")
           end
          if params[:id].present?
            @product = Product.find(params[:id])
            return display_error("Product Not Present ")  unless @product.present?
          end

           if I18n.locale.to_s == "ar"
             @product.description = @product.ar_description
             @product.title = @product.ar_title
           end

           return render json: {api_status: true, locale: I18n.locale.to_s, product: @product}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end

      def list_products
        begin
        if params[:category_id].present?
          category = Category.find(params[:category_id])
          products =    category.products
        else
          products = Product.all
        end

        if I18n.locale.to_s == "ar"
          products.each do |pr|
            pr.description = pr.ar_description
            pr.title = pr.ar_title
          end
        end

        render json: {api_status: true, locale: I18n.locale.to_s, heading: I18n.t('products'), products: products}
        rescue => e
          render json: {api_status: false, message: "Try again later"}
         end
        end

      def list_categories
        category =  Category.all
        if I18n.locale.to_s == "ar"
          category.each do |cat|
            cat.title = cat.ar_title
            cat.description = cat.ar_description
          end
        end
        render json: {api_status: true, locale: I18n.locale.to_s,  heading: I18n.t('categories'),  categories: category}
      end

      private

        def user
        @user ||= current_user
      end

    end
  end
end
