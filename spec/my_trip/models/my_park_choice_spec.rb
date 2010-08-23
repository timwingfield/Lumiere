require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 

describe MyParkChoice do
  it { should have_field(:name).of_type(String) }
  it { should have_field(:arrive).of_type(String) }
  it { should have_field(:depart).of_type(String) }
  it { should have_field(:park_abbr).of_type(String) }
end
