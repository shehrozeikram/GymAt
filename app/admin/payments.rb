ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name_of_card, :card_number, :expiring_date, :cvc, :subscription_id, :checkout_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name_of_card, :card_number, :expiring_date, :cvc]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :name_of_card
      f.input :card_number
      f.input :expiring_date
      f.input :cvc
      f.input :subscription_id, as: :select,  collection:  Subscription.all.collect{|cat| [cat.id]}
      f.input :checkout_id, as: :select,  collection:  Checkout.all.collect{|cat| [ cat.id]}
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name_of_card
    column :card_number
    column :expiring_date
    column :cvc
    column :subscription_id do |s|
      s.user.id rescue ""
    end
    column :checkout_id do |s|
      s.user.id rescue ""
    end
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    actions
  end

end
