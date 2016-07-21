class UserNotifier < ApplicationMailer
  default :from => 'AssaggiaOlio <info@assaggiaolio.com>'

  def send_receipt_email(order)
    @order = order
    mail(to: @order.billing_address.email, bcc: "info@yellowtulip.it", subject: t('email_receipt_title'))
  end

end
