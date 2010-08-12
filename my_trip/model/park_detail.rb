class ParkDetail 
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :abbr, String
  key :open, String
  key :close, String
  key :emh_am, Boolean, :default => false
  key :emh_pm, Boolean, :default => false

  def to_short_display
    "#{self.abbr}: #{self.open} to #{self.close}"
  end
end
