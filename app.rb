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

get '/create_group' do
  erb :create_group
end

post '/create_group' do
  new_group = Group.create(params[:group])

  if new_group.saved?
    current_user.groups << new_group
    current_user.save
    redirect '/'
  else
    erb :create_group
  end

end

# JOIN GROUP
# ===============================

get '/join_group' do
  erb :join_group
end

post '/join_group' do

  group = Group.first(:group_name => params[:group][:group_name])

  if password_validation(group, params[:group][:password])
    current_user.groups << group
    current_user.save
    redirect '/'
  else
    erb :join_group
  end

end
