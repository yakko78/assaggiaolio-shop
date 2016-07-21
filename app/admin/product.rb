ActiveAdmin.register Product do
  before_filter :skip_sidebar!
  permit_params :capacity_cl, :capacity_floz, :diameter, :height, :price, translations_attributes: [:locale, :id, :title, :description, :_destroy]

  index do
    selectable_column
    column :sku
    column :title
    column :description
    column :capacity_cl
    column :capacity_floz
    column :height
    column :diameter
    column :price
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

  show do
    panel "Dettagli Prodotto" do
      attributes_table_for product do
        row :title
        row :description
        row "titolo inglese" do
          product.title_en
        end
        row "descrizione inglese" do
          product.description_en
        end
        row "titolo spagnolo" do
          product.title_es
        end
        row "descrizione spagnola" do
          product.description_es
        end
      end
    end

    panel "Dati Tecnici" do
      attributes_table_for product do
        row  :capacity_cl
        row  :capacity_floz
        row  :height
        row  :diameter
        row  :price do
          number_to_currency(product.price)
        end
      end
    end

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
