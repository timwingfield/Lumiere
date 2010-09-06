require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe Meal do
  it { should have_field(:name) }
  it { should have_field(:meal_type) }
  it { should have_field(:time).of_type(String) }
  it { should have_field(:notes) }

  describe "when getting the default meal names" do
    before(:each) do
      @names = Meal.default_meal_names
    end

    it 'should have 3 items in the list' do
      @names.should have(3).items
    end

    it 'should contain breakfast' do
      @names.should include('breakfast')
    end

    it 'should contain lunch' do
      @names.should include('lunch')
    end

    it 'should contain dinner' do
      @names.should include('dinner')
    end
  end

  describe "when getting the custom field names" do
    describe "and reading the quick service fields" do
      before :each do
        @qs = Meal.quick_service_fields
      end

      it 'should have 1 item in the list' do
        @qs.should have(1).item
      end

      it 'should contain the field name restaurant' do
        @qs.should include('restaurant')
      end
    end

    describe "and reading the table service fields" do
      before :each do
        @ts = Meal.table_service_fields
      end

      it 'should have 2 items in the list' do
        @ts.should have(2).items
      end

      it 'should contain the field name restaurant' do
        @ts.should include('restaurant')
      end

      it 'should contain the field name confirmation number' do
        @ts.should include('confirmation_number')
      end
    end

    describe "and reading the outside wdw fields" do
      before :each do
        @outside = Meal.outside_wdw_fields
      end
      
      it 'should have 3 items in the list' do
        @outside.should have(3).items
      end

      it 'should contain the field name restaurant' do
        @outside.should include('restaurant')
      end

      it 'should contain the field name reservation number' do
        @outside.should include('reservation_number')
      end

      it 'should contain the field name address' do
        @outside.should include('address')
      end
    end

    describe "and reading the custom meal field names" do
      before :each do
        @custom = Meal.custom_meal_fields
      end

      it 'should have 2 items in the list' do
        @custom.should have(2).items
      end

      it 'should have description in the field names' do
        @custom.should include('description')
      end

      it 'should have location in the field names' do
        @custom.should include('location')
      end
    end
  
    describe "magic readers." do
      before(:each) do
        @magic_meal = Meal.new(:magic => true, :awesome => true)
      end

      it "should return the proper values" do
        @magic_meal.magic.should be_true 
      end

      it "should continue up the responder chain if no attr exists." do 
        lambda{ @magic_meal.foo }.should raise_exception NoMethodError
      end
    
    end

    describe "magic writers" do
      before(:each) do
        @meal_x = Meal.new(:name => "Krusty Krab")
      end

      it 'should reuse the same setters and getters as needed.' do
        @meal_x.foo = "bar"
        @meal_x.foo
        @meal_x.should_not_receive(:method_missing)
        
        @meal_x.foo = "baz"
        @meal_x.foo.should eql("baz")
      end

      it 'should add a new attribute to meal' do
        @meal_x.foo = "bar"
        @meal_x.foo.should eql("bar")
      end
    end

  end

end
