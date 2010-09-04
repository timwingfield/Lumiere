require 'sinatra/base'

module Lumiere
  module Database
    def self.init_mongo
      if ENV['MONGOHQ_URL']
        Mongoid.database = Mongo::Connection.new("flame.mongohq.com", 27029).db('LumiereStaging') 
        Mongoid.database.authenticate('lumiere', 'G@st0n')
      else
        Mongoid.database = Mongo::Connection.new("localhost").db('LumiereDev')
      end

      Mongoid.configure do |config|
        config.allow_dynamic_fields = true 
      end
    end
  end
end
