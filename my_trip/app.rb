require 'rubygems'
require 'sinatra/base'
require 'mongoid'
require 'lib/meal_helpers'

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

    @breakfast = @park_day.find_meal_by_name('Breakfast')

    haml :park_choices
  end  

  post "/park_choices" do
    @trip = Trip.find_by_slug params[:trip]
    @park_day = @trip.find_park_day_by_slug params[:park_day]

    #The Leon way. Should be fixed. TW - 9/3
    # %w(morning afternoon evening).each do |time_of_day|
    #   @park_day.send(:save_park_choice, ["#{time_of_day.capitalize}"], params["#{time_of_day}_park_abbr".to_sym]) unless params["#{time_of_day}_park_abbr".to_sym] == "none"
    # end
    
    @park_day.save_park_choice("Morning", params[:morning_park_abbr]) unless params[:morning_park_abbr] == "none"
    @park_day.save_park_choice("Afternoon", params[:afternoon_park_abbr]) unless params[:afternoon_park_abbr] == "none"
    @park_day.save_park_choice("Evening", params[:evening_park_abbr]) unless params[:evening_park_abbr] == "none"
  
    redirect "/park_day/#{@trip.slug}/#{@park_day.slug}"
  end

  post "/save_meal" do
    @trip = Trip.find_by_slug params[:trip]
    @park_day = @trip.find_park_day_by_slug params[:park_day]

    meal_type = params[:meal_type].gsub(" ", "_").downcase

    m = Meal.new(:name => params[:name],
                  :meal_type => meal_type,
                  :time => params[:time],
                  :notes => params[:notes])

    Meal.send("#{meal_type}_fields".to_sym).each do |field|
      m.write_attribute(field.to_sym, params[field.to_sym])
    end

    @park_day.save_meal(m)

    MealHelpers.format_for_park_day(m)
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
