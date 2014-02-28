require 'sinatra/base'

module Lumiere
  module Database
    def self.init_mongo
      Mongoid.database = Mongo::Connection.new("localhost").db('LumiereDev')

      Mongoid.configure do |config|
        config.allow_dynamic_fields = true 
      end
    end
  end
end
