ActiveAdmin.register Trainer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :trainer_type, :subscribers, :rating, avatar: [], attachments: []

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :name
      f.input :trainer_type
      f.input :subscribers
      f.input :rating
      # f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :avatar, as: :file, input_html: { multiple: true }
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :trainer_type
    column :rating
    # column :user_id do |s|
    #   s.user.first_name rescue ""
    # end
    column :avatar do |ad|
      ul do
        ad.avatar.each do |image|
          li do
            image_tag(image.url, width: 100, height: 100) rescue ""
          end
        end
      end
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
