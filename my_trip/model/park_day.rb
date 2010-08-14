class ParkDay 
  include Mongoid::Document
  include Mongoid::Timestamps


  field :date, :type => Date
  field :slug, :type => String

  embeds_many :park_details
  embedded_in :trip, :inverse_of => :park_days

  def to_s
    self.date.strftime("%b %d")
  end

  #TODO: Create something that will display park names/hours on view page

  before_create :add_park_details
  after_create :slugify

  def find_park_detail_by_abbr(abbr)
    self.park_details.find_all {|d| d.abbr == abbr}.first
  end

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
  end

  private

  def slugify
    self.slug = self.date.strftime("%b %d").downcase.gsub(" ", "")
    save
  end

end
