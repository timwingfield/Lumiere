require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe ParkDay do
  it { ParkDay.keys.should include('date') }
  
  it { ParkDay.keys['date'].type.should eql(Date) }
end
