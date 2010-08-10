require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe ParkDay do
  it { ParkDay.keys.should include('date') }
  
  it { ParkDay.keys['date'].type.should eql(Date) }

  describe "when displaying the park day" do
    before :each do
      @trip = Trip.create(:name => "temp", 
        :start_date => Date.new(2010, 04, 13),
        :end_date => Date.new(2010, 04, 13))
    end

    it 'should return a formatted date when to_s is called' do
      @trip.park_days.first.to_s.should eql("Apr 13")  
    end
  end
end
