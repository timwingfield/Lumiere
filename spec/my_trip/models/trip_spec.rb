require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe Trip do
  before :all do
    MongoMapper.database.collections.each { |c| c.remove } 
  end
  
  it { Trip.keys.should include('name') }
  it { Trip.keys.should include('start_date') }
  it { Trip.keys.should include('end_date') }
  it { Trip.keys.should include('slug') }
  it { Trip.keys.should include('_id') }

  it { Trip.keys['name'].type.should eql(String) }
  it { Trip.keys['start_date'].type.should eql(Date) }
  it { Trip.keys['end_date'].type.should eql(Date) }
  it { Trip.keys['slug'].type.should eql(String) }
  
  describe 'when adding the slug' do
    before :all do
      @trip = Trip.create(:name => "My Trip")
      @complicated = Trip.create!(:name => "B&E go's to I/L/oh")
    end

    it "should have a slug on the new Trip" do
      @trip.slug.should eql('my-trip')
    end

    it "should have a slug for the complicated trip" do
      @complicated.slug.should eql('b-n-e-gos-to-i-l-oh')
    end
  end

  describe "when displaying the trip info" do
    before :all do
      @trip = Trip.create!(
        :name => "My Trip",
        :start_date => Date.new(2010, 12, 1),
        :end_date => Date.new(2010, 12, 5))
    end

    it 'should show the length of the trip in days' do
      @trip.days.should be(5)
    end

    it 'should have a trip length and begins on line' do
      @trip.length_and_begins_on.should eql("5 days beginning on December 01")
    end

    it 'should have a trip legth and begins on line formatted for one day' do
      @trip.end_date = Date.new(2010, 12, 1)
      @trip.length_and_begins_on.should eql("1 day beginning on December 01")
    end
  end

  describe "when adding the park days to a new trip" do
    before :all do
      @trip = Trip.create!(
        :name => "My Trip",
        :start_date => Date.new(2010, 12, 1),
        :end_date => Date.new(2010, 12, 5))    
    end

    it 'should have five park days added' do
      @trip.should have(5).park_days 
    end

    it 'should have the first park day with a date the same as the start date' do
      @trip.park_days.first.date.should eql(@trip.start_date)
    end
  end
end
