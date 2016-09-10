class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      UsersSession.create user: resource, action: 'log_in', authentication: 'direct'
    end
  end

  def destroy
    user = current_user
    type = params[:type].present? ? params[:type] : 'indirect'
    super do |resource|
      UsersSession.create user: user, action: 'log_out', authentication: type
    end
  end
end