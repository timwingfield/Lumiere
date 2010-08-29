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
  
  get "/park_day/:trip/:park_day" do
    @trip = Trip.find_by_slug params[:trip]
    @park_day = @trip.find_park_day_by_slug params[:park_day]

    haml :park_day
  end

  get "/park_choices/:trip/:park_day" do
    @trip = Trip.find_by_slug params[:trip]
    @park_day = @trip.find_park_day_by_slug params[:park_day]
    @park_list = %w(none MK EP DS AK TL BB)

    haml :park_choices
  end  

  post "/park_choices" do
    @trip = Trip.find_by_slug params[:trip]
    @park_day = @trip.find_park_day_by_slug params[:park_day]

    # The Leon way. Refactor to this someday.
    # %w(morning afternoon evening).each do |time_of_day|
    #   @park_day.send(:save_park_choice, ["#{time_of_day[0].upcase}#{time_of_day[1..-1]}"], params["#{time_of_day}_park_abbr".to_sym]) unless params["#{time_of_day}_park_abbr".to_sym] == "none"
    # end
    @park_day.save_park_choice("Morning", params[:morning_park_abbr]) unless params[:morning_park_abbr] == "none"
    @park_day.save_park_choice("Afternoon", params[:afternoon_park_abbr]) unless params[:afternoon_park_abbr] == "none"
    @park_day.save_park_choice("Evening", params[:evening_park_abbr]) unless params[:evening_park_abbr] == "none"
  
    redirect "/park_day/#{@trip.slug}/#{@park_day.slug}"
  end

  post "/save_details" do
    @trip = Trip.find_by_slug params[:trip]
    @details = @trip.find_park_day_by_slug(params[:park_day]).find_park_detail_by_abbr(params[:park])

    @details.open = params[:open]
    @details.close = params[:close]
    @details.emh_am = params[:emh_am] == 'on'
    @details.emh_pm = params[:emh_pm] == 'on'
    @details.save

    @details.to_short_display
  end

end
