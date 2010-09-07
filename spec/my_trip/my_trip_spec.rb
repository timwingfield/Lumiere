require File.expand_path(File.dirname(__FILE__) + '/../spec_helper') 

describe MyTrip do
  include Rack::Test::Methods

  before :each do
    @request = Rack::MockRequest.new(MyTrip)
  end

  describe "when getting the index page" do
    before :each do
      @response = @request.get '/'
    end

    it "my trip should respond to /" do
      @response.should be_ok
    end

    it 'should have the user landing top div' do
      @response.body.should include("id='user-landing-top'")
    end
  end
end
