ActiveAdmin.register DishOrder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :self_pickup, :delivery, :discount, :latitude, :longitude, :user_id, :resturant_dish_id, :payment_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:self_pickup, :delivery, :discount, :user_id, :resturant_dish_id, :payment_id, :latitude, :longitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :self_pickup
      f.input :delivery
      f.input :discount
      f.input :latitude
      f.input :longitude
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :resturant_dish_id, as: :select,  collection:  ResturantDish.all.collect{|cat| [cat.title, cat.id]}
      f.input :payment_id, as: :select,  collection:  Payment.all.collect{|cat| [ cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :self_pickup
    column :delivery
    column :discount
    column :latitude
    column :longitude
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :resturant_dish_id do |s|
      s.user.title rescue ""
    end
    column :payment_id do |s|
      s.user.id rescue ""
    end
    actions
  end

end
