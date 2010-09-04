require 'sinatra/base'

module Lumiere
  module Database
    def self.init_mongo
      if ENV['MONGOHQ_URL']
        #get the mongo hq shiznit in here
      else
        connection = Mongo::Connection.new("localhost")
        Mongoid.database = connection.db('LumiereDev')
      end
    end
  end
end
