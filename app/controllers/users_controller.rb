class UsersController < ApplicationController

  def index
    @sort_strategy = order_params
    @users = User.all.order email: @sort_strategy
  end

  def show
    @user = User.find params[:id]
    @user_sessions = UsersSession.where(user: @user)
  end
end