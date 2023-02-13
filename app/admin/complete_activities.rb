ActiveAdmin.register CompleteActivity do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :activity_id, :user_id, :item_1, :item_2, :item_3, :item_4, :item_5
  #
  # or
  #
  # permit_params do
  #   permitted = [:activity_id, :user_id, :item_1, :item_2, :item_3, :item_4, :item_5]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
