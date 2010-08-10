require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'

class MyTrip < Sinatra::Base
  set :static, true
  set :public, 'public'
  
  configure :development do
    MongoMapper.connection = Mongo::Connection.new('localhost')
    MongoMapper.database = 'LumiereDev'    
  end

  get "/" do
    haml :index
  end

  get "/new" do
    haml :new
  end

  get "/view/:trip" do
    @trip = Trip.find_by_slug(params[:trip])
    haml :view
  end

  post "/new" do
    Trip.create(params)
    redirect '/list'
  end

  get "/list" do
    @trips = Trip.all
    haml :list
  end
end
