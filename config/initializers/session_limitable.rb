Warden::Manager.after_set_user :only => :fetch do |record, warden, options|
  scope = options[:scope]
  env   = warden.request.env

  if record.respond_to?(:unique_session_id) && warden.authenticated?(scope) && options[:store] != false
    if record.unique_session_id != warden.session(scope)['unique_session_id'] && !env['devise.skip_session_limitable']
      warden.raw_session.clear
      warden.logout(scope)
      UsersSession.create user: record, action: 'log_out', authentication: 'indirect'
      throw :warden, :scope => scope, :message => :session_limited
    end
  end
end
