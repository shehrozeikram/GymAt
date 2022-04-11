ActiveAdmin.register Service do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :title, :ar_title, :ar_description, :type, :service_provider_id, :ratings, :description,  :tag_list, :service_type_list

  # or
  #
  # permit_params do
  #   permitted = [:title, :ar_title, :ar_description, :type, :service_provider_id, :ratings, :description, :attachments, :tag_list, :service_type_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  # form(html: {multipart: true}) do |f|
  #   f.inputs do
  #     f.input :title
  #     f.input :ar_title
  #     f.input :description
  #     f.input :ar_description
  #     f.input :service_provider_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
  #     f.input :ratings
  #     f.input :tag_list
  #     f.input :service_type_list
  #     f.input :attachments, as: :file, input_html: { multiple: true }
  #   end
  #   f.actions
  # end
  #
  # index do
  #   selectable_column
  #   id_column
  #   column :title
  #   column :ar_title
  #   column :description
  #   column :ar_description
  #   column :service_provider_id
  #   column :ratings
  #   column :tag_list
  #   column :service_type_list
  #   column :attachments do |ad|
  #     ul do
  #       ad.attachments.each do |image|
  #         li do
  #           image_tag(image.url, width: 100, height: 100) rescue ""
  #         end
  #       end
  #     end
  #   end
  #   actions
  # end


end
