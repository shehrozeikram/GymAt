ActiveAdmin.register Activity do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :day, :title, :times, :minutes, :calories, :avg_frequency, :max_frequency, :breaks, :breaks_time, :training_program_id, :trainer_id, attachments: []
   #
  # or
  #
  # permit_params do
  #   permitted = [:attachments, :title, :times, :minutes, :calories, :avg_frequency, :max_frequency, :breaks, :breaks_time, :training_program_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :day
      f.input :title
      f.input :times
      f.input :minutes
      f.input :calories
      f.input :avg_frequency
      f.input :max_frequency
      f.input :breaks
      f.input :breaks_time
      f.input :trainer_id, as: :select,  collection:  Trainer.all.collect{|cat| [cat.name, cat.id]}
      f.input :training_program_id, as: :select,  collection:  TrainingProgram.all.collect{|cat| [cat.id]}
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :day
    column :title
    column :times
    column :minutes
    column :calories
    column :avg_frequency
    column :max_frequency
    column :breaks
    column :breaks_time
    column :training_program_id do |s|
      s.user.id rescue ""
    end
    column :trainer_id do |s|
      s.user.name rescue ""
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
