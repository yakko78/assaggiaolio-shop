ActiveAdmin.register Product do
  before_filter :skip_sidebar!
  permit_params :capacity_cl, :capacity_floz, :diameter, :height, :price, translations_attributes: [:locale, :id, :title, :description, :_destroy]

  index do
    column :sku
    column :title
    column :description
    column :capacity_cl
    column :capacity_floz
    column :height
    column :diameter
    column :price
    selectable_column
    actions
  end


  form do |f|
    # ...
    f.inputs "Translated fields" do
      f.translated_inputs 'ignored title', switch_locale: true do |t|
        t.input :title
        t.input :description
      end
    end

    f.inputs "Dati tecnici" do
      f.input :capacity_cl
      f.input :capacity_floz
      f.input :height
      f.input :diameter
      f.input :price
    end

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
