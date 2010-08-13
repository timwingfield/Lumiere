require 'rubygems'
require 'sinatra/base'
require 'mongoid'

class MyTrip < Sinatra::Base
  set :static, true
  set :public, 'public'
  
  configure :development do
    connection = Mongo::Connection.new
    Mongoid.database = connection.db('LumiereDev')
  end

  get "/" do
    haml :index
  end

  get "/new" do
    haml :new
  end

  get "/view/:trip" do
    @trip = Trip.first(:conditions => {:slug => params[:trip]})
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
    @trip = Trip.where(:slug => params[:trip]).first
    @park_day = @trip.park_days.find_all {|p| p.slug == params[:park_day]}.first
    @details = @park_day.park_details.find_all {|d| d.abbr == params[:park]}.first

    haml :edit_detail
  end

end
