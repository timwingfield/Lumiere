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
    if self.emh_am then am = "EMH " end
    if self.emh_pm then pm = " EMH" end

    "#{self.abbr}: #{am}#{self.open} to #{self.close}#{pm}"
  end
end
