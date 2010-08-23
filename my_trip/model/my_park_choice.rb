class MyParkChoice 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :arrive
  field :depart
  field :park_abbr

  embedded_in :park_day, :inverse_of => :my_park_choices
end
