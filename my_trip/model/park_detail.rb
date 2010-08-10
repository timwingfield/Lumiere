class ParkDetail 
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :abbr, String
  key :open, String
  key :close, String
  key :emh_am, Boolean
  key :emh_pm, Boolean
end
