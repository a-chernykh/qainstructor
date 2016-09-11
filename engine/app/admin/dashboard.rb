ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel 'Stats' do
          table do
            thead do
              tr do
                th(colspan: 2) { 'Main' }
              end
            end
            tbody do
              tr do
                td 'Registered users'
                td User.count
              end
              tr do
                td 'Paying users'
                td User.where.not(stripe_customer_id: nil).count
              end
              tr do
                td 'Revenue'
                td number_to_currency(Purchase.sum(:charge_cents) / 100.to_f)
              end
            end
          end
        end
      end
      column do
        panel "Useful links" do
          ul do
            li { link_to 'Sidekiq Dashboard', '/sidekiq' }
          end
        end
      end
    end
  end # content
end
