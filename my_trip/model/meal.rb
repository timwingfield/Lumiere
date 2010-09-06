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

private

  def create_method(name, &block)
    self.class.send(:define_method, name, &block)
  end

  def method_missing(message, *args, &blk)
    msg_string = message.to_s
    if(msg_string =~ /.+=/)
      create_method(message) do |val|
        self.write_attribute(msg_string.gsub(/=/,""), val)
      end
      return send(message, args.first)
    elsif(self.read_attribute(message))
      create_method(message) do
        self.read_attribute(message) 
      end
      return send(message)
    end
    super(message, *args, &blk)
  end
end
