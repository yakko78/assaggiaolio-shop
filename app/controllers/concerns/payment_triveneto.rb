module PaymentTriveneto
  extend ActiveSupport::Concern

  private

    def pay_triveneto(amount_to_pay)
      require 'uri'
      require 'net/http'

      id = '11115604'
      password = 'Francesco71'
      action = '4'
      amt = amount_to_pay.to_s
      currencycode = '978'
      langid = 'ITA'
      responseURL = 'http://www.google.it'
      errorURL = 'http://www.microsoft.it'

      trackid = "AO" + Time.now.to_i.to_s

      params = {
        'id' =>id,
        'password' => password,
        'action' => action,
        'amt' => amt,
        'currencycode' => currencycode,
        'langid' => langid,
        'responseURL' => responseURL,
        'errorURL' => errorURL,
        'trackid' => trackid
      }

      url = 'https://www.constriv.com/cg/servlet/PaymentInitHTTPMobileServlet'

      test = Net::HTTP.post_form(URI.parse(url), params)
      puts test.body
      returnValue = test.body.split(':https://')

      finalURL = 'https://'+returnValue[1]+'?PaymentID='+returnValue[0]

      puts finalURL

    end
end
