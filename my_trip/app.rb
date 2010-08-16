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
    @trip = Trip.find_by_slug params[:trip]
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
    @trip = Trip.find_by_slug params[:trip]
    @park_day = @trip.find_park_day_by_slug params[:park_day]
    @details = @park_day.find_park_detail_by_abbr params[:park]

    haml :edit_detail
  end

  post "/save_details/:trip/:park_day/:park" do
    @trip = Trip.find_by_slug params[:trip]
    @details = @trip.find_park_day_by_slug(params[:park_day]).find_park_detail_by_abbr(params[:park])

    @details.open = params[:open]
    @details.close = params[:close]
    @details.emh_am = params[:emh_am] == 'on'
    @details.emh_pm = params[:emh_pm] == 'on'
    @details.save

    redirect "/view/#{params[:trip]}"
  end

end
