ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :contact_number, :password, attachments: []

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :contact_number
      f.input :password
      # f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :contact_number
    column :password
    # column :user_id do |s|
    #   s.user.first_name rescue ""
    # end
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
