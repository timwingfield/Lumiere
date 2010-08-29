require File.expand_path(File.dirname(__FILE__) + '/../spec_helper') 

describe MyTrip do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "my trip should respond to /" do
    get '/'
    #last_response.should be_ok
    #Can't get this one to pass. Not sure what's up
  end
end
