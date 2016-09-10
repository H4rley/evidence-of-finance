class UserMailer < ApplicationMailer

  def critical_amount_on_account(account)
    @account = account
    @url  = 'http://example.com/login'
    mail(to: "viktoria.lovasova@gmail.com", subject: 'You exceeded your critical amount on your account.')
  end

end
