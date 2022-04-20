ActiveAdmin.register ServiceAvailability do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :day, :start_time, :end_time, :service_id, :service_provider_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:day, :start_time, :end_time, :service_id, :service_provider_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :day
      f.input :service_provider_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :start_time
      f.input :end_time
    end
    f.actions
  end
end
