ActiveAdmin.register Checkout do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :free_delivery, :price, :quantity, :sub_total, :shipping_fee, :discount, :total, :user_id, :shop_id, :payment_id, attachments: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :attachments, :free_delivery, :price, :quantity, :sub_total, :shipping_fee, :discount, :total, :user_id, :shop_id, :payment_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :free_delivery
      f.input :price
      f.input :quantity
      f.input :sub_total
      f.input :shipping_fee
      f.input :discount
      f.input :total
      f.input :payment_id
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :shop_id, as: :select,  collection:  Shop.all.collect{|cat| [cat.title, cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :free_delivery
    column :price
    column :quantity
    column :sub_total
    column :shipping_fee
    column :discount
    column :total
    column :payment_id
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :shop_id do |s|
      s.user.title rescue ""
    end
    column :attachments do |ad|
      ul do
        ad.attachments.each do |image|
          li do
            image_tag(image.url, width: 100, height: 100) rescue ""
          end
        end
      end
    end
    actions
  end

end
