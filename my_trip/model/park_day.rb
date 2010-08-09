class ParkDay 
  include MongoMapper::EmbeddedDocument

  key :date, Date
end
