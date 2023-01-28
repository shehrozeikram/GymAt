ActiveAdmin.register TrainingProgram do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :training_level, :days, :trainer_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:training_level, :days, :trainer_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :training_level
      f.input :days
      f.input :trainer_id, as: :select,  collection:  Trainer.all.collect{|cat| [cat.name, cat.id]}
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :training_level
    column :days
    column :trainer_id do |s|
      s.name rescue ""
    end

    column :user_id do |s|
      s.user.first_name rescue ""
    end

    actions
  end

end
