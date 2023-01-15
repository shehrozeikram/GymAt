ActiveAdmin.register Subscription do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :full_name, :start_date, :subscription_type, :amount, :discount, :special_offer, :total_amount, :payment_id, :user_id, :business_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:full_name, :start_date, :subscription_type, :amount, :discount, :special_offer, :total_amount, :payment_id, :user_id, :business_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :full_name
      f.input :start_date
      f.input :subscription_type
      f.input :amount
      f.input :discount
      f.input :special_offer
      f.input :total_amount
      f.input :payment_id, as: :select,  collection:  Payment.all.collect{|cat| [ cat.id]}
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :business_id, as: :select,  collection:  Business.all.collect{|cat| [cat.title, cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :full_name
    column :start_date
    column :subscription_type
    column :amount
    column :discount
    column :special_offer
    column :total_amount
    column :payment_id do |s|
      s.user.id rescue ""
    end
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :business_id do |s|
      s.business.title rescue ""
    end
    actions
  end

end
