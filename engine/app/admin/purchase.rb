ActiveAdmin.register Purchase do
  actions :index

  index do
    id_column

    column :user
    column :course
    column :charged do |p|
      number_to_currency(p.charge_cents / 100.to_f)
    end
    column :created_at

    actions
  end
end
