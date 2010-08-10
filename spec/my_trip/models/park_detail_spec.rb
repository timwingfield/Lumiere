require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe ParkDetail do
  it { should have_at_least(6).keys }
  
  it { ParkDetail.keys.should include('name') }
  it { ParkDetail.keys.should include('abbr') }
  it { ParkDetail.keys.should include('open') }
  it { ParkDetail.keys.should include('close') }
  it { ParkDetail.keys.should include('emh_am') }
  it { ParkDetail.keys.should include('emh_pm') }

  it { ParkDetail.keys['name'].type.should eql(String) }
  it { ParkDetail.keys['abbr'].type.should eql(String) }
  it { ParkDetail.keys['open'].type.should eql(String) }
  it { ParkDetail.keys['close'].type.should eql(String) }
  it { ParkDetail.keys['emh_am'].type.should eql(Boolean) }
  it { ParkDetail.keys['emh_pm'].type.should eql(Boolean) }

  describe "when displaying the park hours in short form" do
    before :all do
      @trip = Trip.create(:name => "temp", 
        :start_date => Date.new(2010, 04, 13),
        :end_date => Date.new(2010, 04, 13))

      @ak = @trip.park_days.first.park_details.first
    end
    
    it 'should be formatted abbr: open to close' do
      @ak.to_short_display.should eql('AK: 9 to 7') 
    end
  end
end
