class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      UsersSession.create user: resource, action: 'log_in', authentication: 'direct'
    end
  end
end