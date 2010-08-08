require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'

class MyTrip < Sinatra::Base
  get "/" do
    haml :index
  end
end
