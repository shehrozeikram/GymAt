ActiveAdmin.register Resturant do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, attachments: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :attachments]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
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
