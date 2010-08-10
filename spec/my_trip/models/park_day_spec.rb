require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe ParkDay do
  it { ParkDay.keys.should include('date') }
  
  it { ParkDay.keys['date'].type.should eql(Date) }

  describe "when displaying the park day" do
    before :all do
      @trip = Trip.create(:name => "temp", 
        :start_date => Date.new(2010, 04, 13),
        :end_date => Date.new(2010, 04, 13))

      @my_day = @trip.park_days.first
    end

    it 'should return a formatted date when to_s is called' do
      @my_day.to_s.should eql("Apr 13")  
    end

    describe "when adding the park details" do
      before :all do
        @detail = @my_day.park_details.first
      end

      it 'should have 6 parks in the park details list' do
        @my_day.park_details.should have(6).park_detail
      end

      it 'should have the AK as the abbr in the first item' do
        @detail.abbr.should eql("AK")
      end
    end
  end
end
