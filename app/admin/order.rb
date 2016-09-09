ActiveAdmin.register Order do
  before_filter :skip_sidebar!, :only => :index

  permit_params :processed
  actions :all, :except => [:new]

  scope "Evasi", :was_processed
  scope "Non evasi", :was_not_processed
  scope "Tutti", :all, default: true

  form do |f|

    panel "Evadere l'ordine?" do
      f.input :processed, :as => :radio, label: ""
    end


    f.submit

  end

  index do
    selectable_column
    column "Ordine n.", :id
    column "Data", :purchased_at

    column "Cliente", :billing_address do |order|
      "#{order.billing_address.firstname.titleize} #{order.billing_address.lastname.titleize}"
    end
    column "Totale" do |order|
      number_to_currency(order.total)
    end
    column "Evaso", :processed
    actions
  end

  sidebar "Dettagli Cliente", :only => :show do
    table_for order do
      column "Indirizzo di fatturazione" do |o|
        composedString = "
          #{o.billing_address.firstname.titleize} #{o.billing_address.lastname.titleize} <br>
          #{o.billing_address.address.titleize}<br>
          #{o.billing_address.zip} #{o.billing_address.city.titleize}<br>
          #{o.billing_address.province.titleize}<br>
          #{o.billing_address.shipping_table_rate.country_name}<br><br>

          Email: #{o.billing_address.email}<br>
          Tel. #{o.billing_address.telephone}

        ".html_safe

        if o.billing_address.vat?
          composedString += "<br><br>P.IVA: #{o.billing_address.vat}".html_safe
        end

        composedString

      end
    end
    table_for order do
      column "Indirizzo di spedizione" do |o|
        "
          #{o.shipping_address.firstname.titleize} #{o.shipping_address.lastname.titleize} <br>
          #{o.shipping_address.address.titleize}<br>
          #{o.shipping_address.zip} #{o.shipping_address.city.titleize}<br>
          #{o.shipping_address.province.titleize}<br>
          #{o.shipping_address.shipping_table_rate.country_name}<br><br>

          Tel. #{o.shipping_address.telephone}

        ".html_safe
      end
    end
  end

  sidebar "Ordine evaso", :only => :show do
    span status_tag order.processed
  end

  show do

    panel "Articoli" do
      table_for order.line_items do
        column "Immagine" do |li|
          image_tag li.product.image, class:'img-responsive', width: 50
        end
        column "Prodotto" do |li|
          li.product.title
        end
        column "Prezzo" do |li|
          "#{li.quantity} x #{number_to_currency(li.product.price)}"
        end
      end
    end

    panel "Note"do
      order.notes
    end

    panel "Importo" do
      attributes_table_for order do
        row "Subtotale" do
          number_to_currency(order.subtotal)
        end
        row "Spese di spedizione" do
          number_to_currency(order.shipping_cost)
        end
        row "Totale" do
          number_to_currency(order.amount_to_pay)
        end
      end
    end

    panel "Dettagli Pagamento" do
      attributes_table_for order do
        row "Modalità di pagamento" do
          if (order.pay_type == "1")
            "PayPal"
          elsif (order.pay_type == "2")
            "Carta di Credito"
          end
        end
        row "ID Transazione" do
          order.transaction_id
        end
        row "Stato" do
          order.status
        end
      end
    end

  end


# See permitted parameters documentation:
# https://githuo.billing_address.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
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
