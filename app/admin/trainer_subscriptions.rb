ActiveAdmin.register TrainerSubscription do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :start_date, :end_date, :time, :trainer_id, :user_id

  form(html: {multipart: true}) do |f|
    f.inputs do
      f.input :start_date
      f.input :end_date
      f.input :time
      f.input :trainer_id, as: :select,  collection:  Trainer.all.collect{|cat| [cat.name, cat.id]}
      f.input :user_id, as: :select,  collection:  User.all.collect{|cat| [cat.first_name, cat.id]}
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :start_date
    column :end_date
    column :time
    column :trainer_id do |s|
      s.trainer.name rescue ""
    end
    column :user_id do |s|
      s.user.first_name rescue ""
    end
    actions
  end
  
end
