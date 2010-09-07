require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'my_trip/app'
require 'rack/test'
require 'rspec'
require 'mongoid'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

Mongoid.configure do |config|
  name = "LumiereTest"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
end
Dir["lib/*"].each {|file| require file}
Dir["my_trip/model/*"].each {|file| require file }

require 'mongoid-rspec'

RSpec.configure do |config|
  config.include Mongoid::Matchers
  config.mock_with :rspec
  config.before :all do
    Trip.destroy_all()
  end
end
