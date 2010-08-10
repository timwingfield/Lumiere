class ParkDay 
  include MongoMapper::EmbeddedDocument

  key :date, Date

  many :park_details

  def to_s
    self.date.strftime("%b %d")
  end

  #TODO: Create something that will display park names/hours on view page

  after_create :add_park_details

  private

  def add_park_details
    [
      {:abbr => "AK", :name => "Animal Kingdom", :open => "9", :close => "7"},
      {:abbr => "EP", :name => "Epcot", :open => "9", :close => "9"},
      {:abbr => "MK", :name => "Magic Kingdom", :open => "9", :close => "10"},
      {:abbr => "HS", :name => "Hollywood Studios", :open => "9", :close => "8"},
      {:abbr => "TL", :name => "Typhoon Lagoon", :open => "9", :close => "7"},
      {:abbr => "BB", :name => "Blizzard Beach", :open => "9", :close => "7"}
    ].each do |park|
      self.park_details << ParkDetail.new(
        :abbr => park[:abbr],
        :name => park[:name],
        :open => park[:open],
        :close => park[:close])
    end
    save
  end
end
