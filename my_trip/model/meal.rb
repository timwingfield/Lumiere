class Meal
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :meal_type
  field :time
  field :notes

  embedded_in :park_day, :inverse_of => :meals

  def self.default_meal_names
    %w(breakfast lunch dinner)
  end

  def self.quick_service_fields
    ["restaurant"]
  end

  def self.table_service_fields
    ["restaurant", "confirmation_number"]
  end

  def self.outside_wdw_fields
    ["restaurant", "reservation_number", "address"]
  end

  def self.custom_meal_fields
    ["description", "location"]
  end
end
