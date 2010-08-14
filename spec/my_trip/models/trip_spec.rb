require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe Trip do
  it { should have_field(:name).of_type(String) }
  it { should have_field(:start_date).of_type(Date) }
  it { should have_field(:end_date).of_type(Date) }
  it { should have_field(:slug).of_type(String) }

  describe 'when adding the slug' do
    before :all do
      @trip = Trip.create(:name => "My Trip")
      @complicated = Trip.create(:name => "B&E go's to I/L/oh")
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
      @trip = Trip.create(
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
      @trip = Trip.create(
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

  describe "when finding a trip" do
    before :all do
      @trip1 = Trip.create(
        :name => "My Trip2",
        :start_date => Date.new(2010, 12, 1),
        :end_date => Date.new(2010, 12, 5))    
    end
    
    describe "by slug" do
      before :all do
        @t = Trip.find_by_slug("my-trip2")
      end

      it 'should find trip 1 by the my-trip slug' do
        @t.should_not be_nil
      end 

      it 'should have the correct slug' do
        @t.slug.should eql('my-trip2')
      end

      it 'should have five park days' do
        @t.should have(5).park_days
      end
    end

    describe "and querying its embedded documents" do
      describe "and querying park days" do
        before :each do
          t = Trip.find_by_slug('my-trip2')
          @pd = t.find_park_day_by_slug("dec02")
        end

        it 'should return a park day' do
          @pd.should be_a(ParkDay)
        end

        it 'should have a slug of dec2' do
          @pd.slug.should eql('dec02')
        end

        it 'should have 6 park details' do
          @pd.should have(6).park_details
        end
      end
    end
  end
end
