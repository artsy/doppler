module WardenHelper
  def authenticated?(*args)
    warden.authenticated?(*args)
  end

  def current_user(*args)
    warden.user(*args)
  end

  def current_user=(user)
    warden.set_user user
  end

  def warden
    request.env['warden']
  end
end
