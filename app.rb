require 'sinatra'
require_relative 'config/session'
require_relative 'models'

get '/' do
  "Hello"
end
