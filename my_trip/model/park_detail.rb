class ParkDetail 
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name
  field :abbr
  field :open
  field :close
  field :emh_am, :type => Boolean, :default => false
  field :emh_pm, :type => Boolean, :default => false

  embedded_in :park_day, :inverse_of => :park_details

  def to_short_display
    "#{self.abbr}: #{self.open} to #{self.close}"
  end
end
