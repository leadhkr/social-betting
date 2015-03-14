helpers do

  def current_user # Assigns @current_user
    return nil unless session.key?(:current_user_id)
    @current_user ||= User.get(session[:current_user_id])
  end

  def logged_in? # Checks whether a user is currently logged in
    !current_user.nil?
  end

  def login!(user) # Logs a user in
    session[:current_user_id] = user.id
    @current_user = user
    redirect '/'
  end

  def log_out! # Logs a user out
    @current_user = nil
    session.delete(:current_user_id)
  end

  def password_validation(instance, password) # Checks whether entered password matches password in db
    instance.password == password
  end

  def add_comma(float_num) # Adds comma when displaying bet amounts in bet table

    num = sprintf("%.2f", float_num)

    dollars = num.split(".").first
    cents = num.split(".").last

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

    arr.join("") + "." + cents

  end

  def remove_dollar_sign(amount) # Removes dollar sign if entered by user when making bet
    amount.gsub("$", "")
  end

  def pluralize_bet # Used to pluralize "bets" in the badge in nav bar
    if current_user.join_bets.to_a.count == 1
      "You have <span class=\"badge\">#{current_user.join_bets.to_a.count}</span> open bet"
    else
      "You have <span class=\"badge\">#{current_user.join_bets.to_a.count}</span> open bets"
    end
  end

end
