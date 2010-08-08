require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require 'mongo_mapper'
require 'my_trip/app'
require 'my_trip/model/trip'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database = 'LumiereTest'
