require 'rubygems'
require 'my_trip/app'
require 'my_trip/model/trip'
#add my_trip/model/* later

map '/' do
  run MyTrip
end
