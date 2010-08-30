require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe ParkDay do
  it { should have_field(:date).of_type(Date) }
  
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

    describe "when slugifying the park day for a link" do
      it 'should have a slug of the day' do
        @my_day.slug.should eql("apr13")
      end
    end

    describe "when finding the park detail by abbr" do
      before :each do
        @pd = @my_day.find_park_detail_by_abbr('MK')
      end

      it 'should be a park detail' do
        @pd.should be_a(ParkDetail) 
      end

      it 'should have the abbr of MK' do
        @pd.abbr.should eql('MK')
      end
    end

    describe "when adding new park choices with the park day save choice method" do
      describe "and adding a new morning park choice" do
        before :each do
          @my_day.save_park_choice("Morning", "MK")
        end

        it 'should add one item to the my park choices collection' do
          @my_day.my_park_choices.should have(1).item
        end

        it 'should have an arrival time of 9 on the new item' do
          @my_day.my_park_choices.first.arrive.should eql("9")
        end

        it 'should have a name of Morning' do
          @my_day.my_park_choices.first.name.should eql("Morning")
        end

        it 'should have a departure of 12' do
          @my_day.my_park_choices.first.depart.should eql("12")
        end

        it 'should have a park abbreviation of MK' do
          @my_day.my_park_choices.first.park_abbr.should eql("MK")
        end

        after :each do
          @my_day.my_park_choices = nil
        end
      end

      describe "and adding a new afternoon park choice" do
        before :each do
          @my_day.save_park_choice("Afternoon", "EP")
        end

        it 'should add one item to the my park choices collection' do
          @my_day.my_park_choices.should have(1).item
        end

        it 'should have an arrival time of 12 on the new item' do
          @my_day.my_park_choices.first.arrive.should eql("12")
        end

        it 'should have a name of Afternoon' do
          @my_day.my_park_choices.first.name.should eql("Afternoon")
        end

        it 'should have a departure of 5' do
          @my_day.my_park_choices.first.depart.should eql("5")
        end

        it 'should have a park abbreviation of EP' do
          @my_day.my_park_choices.first.park_abbr.should eql("EP")
        end

        after :each do
          @my_day.my_park_choices = nil
        end
      end
      
      describe "and adding a new evening park choice" do
        before :each do
          @my_day.save_park_choice("Evening", "DS")
        end

        it 'should add one item to the my park choices collection' do
          @my_day.my_park_choices.should have(1).item
        end

        it 'should have an arrival time of 5 on the new item' do
          @my_day.my_park_choices.first.arrive.should eql("5")
        end

        it 'should have a name of Evening' do
          @my_day.my_park_choices.first.name.should eql("Evening")
        end

        it 'should have a departure of 9' do
          @my_day.my_park_choices.first.depart.should eql("9")
        end

        it 'should have a park abbreviation of DS' do
          @my_day.my_park_choices.first.park_abbr.should eql("DS")
        end

        after :each do
          @my_day.my_park_choices = nil
        end
      end      
    end
    
    describe "when finding a meal by name" do
      before :each do
        @my_day.meals << Meal.new(:name => 'lunch', :meal_type => 'Table Service')
        @meal = @my_day.find_meal_by_name('lunch')
      end

      it 'should have the expected name' do
        @meal.name.should eql('lunch')
      end

      it 'should have the expected type' do
        @meal.meal_type.should eql('Table Service')
      end

      it 'should return nil for an empty search' do
        empty = @my_day.find_meal_by_name('no_way')
        empty.should be_nil
      end

      after :each do
        @my_day.meals = nil
      end
    end

    describe "when saving meals" do
      describe "and saving a new meal" do
        before :each do
          @meal = Meal.new(:name => "lunch", :meal_type => "Quick Service")
          @my_day.save_meal(@meal)
        end

        it 'should have one meal in the list' do
          @my_day.meals.should have(1).item
        end

        it 'should have the same name on the meal as the one saved' do
          @my_day.meals[0].name.should eql(@meal.name)
        end

        after :each do
          @my_day.meals = nil
        end
      end

      describe "and updating an existing meal of the same meal type" do
        before :each do
          @meal = Meal.new(
                  :name => "lunch", 
                  :meal_type => "Quick Service", 
                  :time => "11:45",
                  :restaurant => "Cosmic Ray's")
          @my_day.save_meal(@meal)

          @new_meal = Meal.new(
                  :name => "lunch", 
                  :meal_type => "Quick Service", 
                  :time => "12:30",
                  :restaurant => "Pecos Bills")
          @my_day.save_meal(@new_meal)
        end

        it 'should have 1 meal in the list' do
          @my_day.meals.should have(1).item
        end

        it 'should have the new time on the meal' do
          @my_day.meals[0].time.should eql(@new_meal.time)
        end

        it 'should have the new restuarant name on the meal' do
          @my_day.meals[0].restaurant.should eql(@new_meal.restaurant)
        end

        after :each do
          @my_day.meals = nil
        end
      end
    end
  end
end
