require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe MealHelpers, "when outputting the meal to the park day page" do
  describe "and formatting a quick service meal" do
    before :each do
      m = Meal.new(:meal_type => "quick_service",
          :time => "8:00",
          :notes => "notes",
          :restaurant => "cosmic ray's")
      @out = MealHelpers.format_for_park_day(m)
    end

    it 'should have the meal type' do
      @out.should include('Quick service')
    end

    it 'should have the time' do
      @out.should include('8:00')
    end

    it 'should have any notes' do
      @out.should include('notes')
    end

    it 'should have the restaurant name' do
      @out.should include("cosmic ray's")
    end
  end

  describe "and formatting a table service meal" do
    before :each do
      m = Meal.new(:meal_type => "table_service",
          :time => "8:00",
          :notes => "notes",
          :restaurant => "Flying Fish",
          :confirmation_number => "345678")
      @out = MealHelpers.format_for_park_day(m)
    end

    it 'should have the meal type' do
      @out.should include('Table service')
    end

    it 'should have the time' do
      @out.should include('8:00')
    end

    it 'should have any notes' do
      @out.should include('notes')
    end

    it 'should have the restaurant name' do
      @out.should include("Flying Fish")
    end

    it 'should have the confirmation number of 345678' do
      @out.should include('345678')
    end
  end

  describe "and formatting an outside wdw meal" do
    before :each do
      @m = Meal.new(:meal_type => "outside_wdw",
          :time => "8:00",
          :notes => "notes",
          :restaurant => "Applebees",
          :reservation_number => "345678",
          :address => "1 any street, Orlando, FL")

      @out = MealHelpers.format_for_park_day(@m)
    end
    
    it 'should have the restaurant' do
      @out.should include(@m.restaurant)
    end

    it 'should have the reservation number' do
      @out.should include(@m.reservation_number)
    end

    it 'should have the address' do
      @out.should include(@m.address)
    end
  end

  describe "and formatting a custom meal" do
    before :each do
      @m = Meal.new(:meal_type => "custom_meal",
          :time => "8:00",
          :notes => "notes",
          :description => "resort room breakfast",
          :location => "in our room")

      @out = MealHelpers.format_for_park_day(@m)
    end
    it 'should have the description' do
      @out.should include(@m.description)
    end

    it 'should have the location' do
      @out.should include(@m.location)
    end
  end
end
