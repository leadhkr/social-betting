helpers do

  def current_user
    @current_user ||= User.get(session[:current_user_id])
  end

  def login(user)
    @current_user = user
    session[:current_user_id] = user.id
    redirect '/'
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    @current_user = nil
    session.delete(:current_user_id)
  end

  def password_validation(instance, password)
    instance.password == password
  end

end
