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
  
  get "/edit/:trip/:park_day/:park" do
    @trip = Trip.find_by_slug(params[:trip])
    #@park_day = @trip.park_days.find_all {|t| t.slug == params[:park_day]} 
    @park_day = @trip.park_days.find(params[:park_day])
    #@details = @park_day.park_details.find_all {|d| d.abbr == params[:park]}

    haml :edit_detail
  end

end
