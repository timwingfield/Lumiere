require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require 'mongoid'
require 'my_trip/app'

Mongoid.configure do |config|
  name = "LumiereTest"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
end

Dir["my_trip/model/*"].each {|file| require file }

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

require 'mongoid-rspec'

RSpec.configure do |config|
  config.include RSpec::Matchers
  config.include Mongoid::Matchers
  config.mock_with :rspec
  config.before :all do
    Trip.destroy_all()
  end
end
