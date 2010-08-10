require 'rubygems'
require 'my_trip/app'
Dir["my_trip/model/*"].each {|file| require file }

map '/' do
  run MyTrip
end
