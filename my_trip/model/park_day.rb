class ParkDay 
  include MongoMapper::EmbeddedDocument

  key :date, Date

  def to_s
    self.date.strftime("%b %d")
  end

  private
  park_list = [
    {:abbr => "AK", :name => "Animal Kingdom", :open => "9", :close => "7"},
    {:abbr => "EP", :name => "Epcot", :open => "9", :close => "9"},
    {:abbr => "MK", :name => "Magic Kingdom", :open => "9", :close => "10"},
    {:abbr => "HS", :name => "Hollywood Studios", :open => "9", :close => "8"},
    {:abbr => "TL", :name => "Typhoon Lagoon", :open => "9", :close => "7"},
    {:abbr => "BB", :name => "Blizzard Beach", :open => "9", :close => "7"}
  ]
end
