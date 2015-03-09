require 'sinatra'
require_relative 'helpers'
require_relative 'config/session'
require_relative 'models'

# USER SIGN IN
# ===============================

get '/' do
  erb :home
end

post '/session' do
  user = User.first(params[:user][:email])

  if user && password_validation(user, params[:user][:password])
    login(user)
  else
    redirect '/'
  end

end

# USER REGISTRATION
# ===============================

get '/user' do
  @user = User.new
  erb :new_user
end

post '/user' do

  user = User.create(params[:user])

  if user.saved?
    login(user)
  else
    erb :new_user
  end

end

# USER SIGN OUT
# ===============================

get '/session/logout' do
  log_out
  redirect '/'
end

# CREATE GROUP
# ===============================

get '/new_group' do
  erb :new_group
end

post '/new_group' do
  new_group = Group.create(params[:group])
  current_user.groups << new_group
  current_user.save

  if new_group.saved?
    redirect '/'
  else
    new_group.errors.full_messages
  end
end
