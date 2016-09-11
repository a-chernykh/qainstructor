ActiveAdmin.register Chapter do
  belongs_to :course

  config.sort_order = 'position_asc'

  permit_params :name, :position

  form do |f|
    f.semantic_errors
    f.inputs :position, :name
    f.actions
  end
end
