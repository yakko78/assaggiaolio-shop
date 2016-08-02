class UserNotifier < ApplicationMailer
  default :from => 'AssaggiaOlio <info@faravetrerie.it>'

  def send_receipt_email(order)
    @order = order
    mail(to: @order.billing_address.email, bcc: Rails.application.secrets.paypal_merchant_email, subject: t('email_receipt_title'))
  end

end
