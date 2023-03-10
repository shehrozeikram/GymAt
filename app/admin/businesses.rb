ActiveAdmin.register Business do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :business_type, :description, :city, :opening_time, :closing_time, :distance, :ratings, :longitude, :latitude, :user_id, :tag_list, :price, attachments: []


  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :business_type
      f.input :description
      f.input :city
      f.input :opening_time
      f.input :closing_time
      f.input :distance
      # f.input :service_provider_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :ratings
      f.input :longitude
      f.input :latitude
      f.input :tag_list
      f.input :price
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :business_type
    column :description
    column :city
    column :opening_time
    column :closing_time
    column :distance
    column :ratings
    column :longitude
    column :latitude
    column :tag_list
    column :user_id do |s|
      s.user.first_name rescue ""
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
