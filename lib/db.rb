require 'sinatra/base'

module Lumiere
  module Database
    def self.init_mongo
      if ENV['MONGOHQ_URL']
        connection = Mongo::Connection.new(ENV['MONGOHQ_URL'])
        Mongoid.database = connection.db('LumiereStaging')
      else
        connection = Mongo::Connection.new("localhost")
        Mongoid.database = connection.db('LumiereDev')
      end
    end
  end
end
