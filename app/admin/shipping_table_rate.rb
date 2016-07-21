ActiveAdmin.register ShippingTableRate do
  before_filter :skip_sidebar!

  permit_params :country_name, :a, :b, :c, :d, :e

  form do |f|
    f.inputs "Tabella di Spedizione" do
      f.input :country_name
      f.input :a
      f.input :b
      f.input :c
      f.input :d
      f.input :e

      f.submit
    end
  end

  index do
    selectable_column
    column :country_name
    column :a
    column :b
    column :c
    column :d
    column :e
    actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
