ActiveAdmin.register Redemption do
  actions :index, :show

  index do
    selectable_column
    id_column

    column :user
    column :coupon
    column :redeemed_at

    actions
  end
end
