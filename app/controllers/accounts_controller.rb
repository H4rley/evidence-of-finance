class AccountsController < ApplicationController

  def index
    @accounts = Account.all.order :name
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes account_params
      redirect_to accounts_path, notice: "Account was successfully updated."
    else
      render :edit
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new account_params
    if @account.save
      redirect_to accounts_path, notice: "Account was successfully created."
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :critical_amount, :send_notifications)
  end
end