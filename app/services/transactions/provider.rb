class Transactions::Provider

  attr_reader :account, :transaction

  def initialize(attrs={})
    @account = attrs[:account]
    @transaction = attrs[:transaction]
  end


  def update_account
    begin
      @transaction.save!
      if @transaction.movement == "input"
        @account.sum += @transaction.sum
      else
        @account.sum -= @transaction.sum
      end
      @account.save!
    end
  end

  def notify_user
    return unless @account.send_notifications
    UserMailer.critical_amount_on_account(@account).deliver_now if @account.sum < @account.critical_amount
  end

end