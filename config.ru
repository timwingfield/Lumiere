require 'rubygems'
require 'my_trip/app'
require 'my_trip/model/trip'
require 'my_trip/model/park_day.rb'
#add my_trip/model/* later

map '/' do
  run MyTrip
end
