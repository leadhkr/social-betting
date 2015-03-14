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

  def add_comma(float_num)

    num = sprintf("%.2f", float_num)

    dollars = num.sub(/\.(.*)/, "")
    cents = num.scan(/\.(.*)/)

    dollars_array = dollars.split("")

    arr = []

    while dollars_array.size > 0
      if dollars_array.size > 3
        arr.unshift(dollars_array.pop)
        arr.unshift(dollars_array.pop)
        arr.unshift(dollars_array.pop)
        arr.unshift(",")
      else
        dollars_array.size.times do |n|
          arr.unshift(dollars_array.pop)
        end
      end
    end

    arr.join("") + "." + cents[0][0]

  end

end
