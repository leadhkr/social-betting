helpers do

  def current_user
    return nil unless session.key?(:current_user_id)
    @current_user ||= User.get(session[:current_user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def login!(user)
    session[:current_user_id] = user.id
    @current_user = user
    redirect '/'
  end

  def log_out!
    @current_user = nil
    session.delete(:current_user_id)
  end

  def password_validation(instance, password)
    instance.password == password
  end

end
