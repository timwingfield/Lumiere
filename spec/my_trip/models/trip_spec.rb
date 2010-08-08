require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 
#something
describe Trip do
  it { should have(4).keys}

  it { Trip.keys.should include('name') }
  it { Trip.keys.should include('start_date') }
  it { Trip.keys.should include('end_date') }
  it { Trip.keys.should include('_id') }

  it { Trip.keys['name'].type.should eql(String) }
  it { Trip.keys['start_date'].type.should eql(Date) }
  it { Trip.keys['end_date'].type.should eql(Date) }
end
