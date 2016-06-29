class UserNotifier < ApplicationMailer
  default :from => 'AssaggiaOlio <info@assaggiaolio.com>'

  def send_receipt_email(order)
    @order = order
    mail(to: @order.billing_address.email, ccn: "info@yellowtulip.it", subject: "Il tuo ordine su AssaggiaOlio")
  end

end
