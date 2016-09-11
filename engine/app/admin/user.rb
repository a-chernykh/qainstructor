ActiveAdmin.register User do
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :stripe_customer_id
    column :created_at
    actions
  end

  sidebar 'User Details', only: [:show, :edit] do
    ul do
      li link_to 'User Completions', admin_user_user_completions_path(user)
      li link_to 'User Courses', admin_user_user_courses_path(user)
    end
  end
end
