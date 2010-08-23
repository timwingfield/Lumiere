require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe ParkDetail do
  it { should have_at_least(6).fields }

  it { should have_field(:name).of_type(String) }
  it { should have_field(:abbr).of_type(String) }
  it { should have_field(:open).of_type(String) }
  it { should have_field(:close).of_type(String) }
  it { should have_field(:emh_am).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:emh_pm).of_type(Boolean).with_default_value_of(false) }
  
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
