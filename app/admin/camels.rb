ActiveAdmin.register Camel do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name,  :gender, :age, :awards, :price, :description, :camel_type, :owner_name, :camel_purpose, :rent_purpose, :attachments, :tag_list, :user_id, :bid_type
  #
  # or

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :name
      f.input :type
      f.input :gender
      f.input :age
      f.input :awards
      f.input :price
      f.input :description
      f.input :camel_type
      f.input :owner_name
      f.input :camel_purpose
      f.input :rent_purpose
      f.input :tag_list
      f.input :bid_type
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}

      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
  
end
