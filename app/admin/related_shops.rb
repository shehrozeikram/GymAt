ActiveAdmin.register RelatedShop do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :price, :description,  :shop_type, :user_id, :quantity,:shop_id, attachments: []

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :title
      f.input :price
      f.input :description
      f.input :shop_type
      f.input :quantity
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
      f.input :shop_id, as: :select,  collection:  Shop.all.collect{|cat| [cat.title, cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :price
    column :description
    column :shop_type
    column :quantity
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    column :shop_id do |s|
      s.user.title rescue ""
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
