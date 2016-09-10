class TransactionsController < ApplicationController

  before_filter :set_account

  rescue_from ActiveRecord::RecordInvalid do |e|
    render :new
  end

  def index
    @transactions = @account.transactions
  end

  def new
    @transaction = @account.transactions.new
  end

  def create
    @transaction = @account.transactions.new transaction_params.merge(user_id: current_user.id)

    if ::Transactions::Provider.new(account: @account, transaction: @transaction).update_account
      redirect_to account_transactions_path, notice: "Transaction was successfully created."
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sum, :purpose, :movement, :category_id)
  end

  def set_account
    @account = Account.find params[:account_id]
  end
end