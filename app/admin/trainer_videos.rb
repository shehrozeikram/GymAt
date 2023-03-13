ActiveAdmin.register TrainerVideo do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :trainer_id, videos: []


  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :trainer_id, as: :select,  collection:  Trainer.all.collect{|cat| [cat.name, cat.id]}
      f.input :videos, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :trainer_id do |s|
      s.user.name rescue ""
    end
    column :videos do |ad|
      ul do
        ad.videos.each do |image|
          li do
            image_tag(image.url, width: 100, height: 100) rescue ""
          end
        end
      end
    end
    actions
  end

end
