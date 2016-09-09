class UsersController < ApplicationController

  def index
    @users = User.all.order :email
  end

  def show
    @user = User.find params[:id]
    @user_sessions = UsersSession.where(user: @user)
  end
end