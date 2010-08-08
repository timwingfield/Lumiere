class Trip
  include MongoMapper::Document

  key :start_date, Date
  key :end_date, Date
  key :name, String
end
