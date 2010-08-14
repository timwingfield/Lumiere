require 'rubygems'
require 'mongoid'

class Trip
  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_date, :type => Date
  field :end_date, :type => Date
  field :name
  field :slug

  embeds_many :park_days

  def days
    (self.end_date - self.start_date + 1).to_i
  end

  def length_and_begins_on
    day_str = "days"
    if self.days == 1
      day_str = "day"
    end
    
    "#{self.days.to_s} #{day_str} beginning on #{self.start_date.strftime("%B %d")}"
  end

  def find_park_day_by_slug(park_day_slug)
    self.park_days.find_all {|p| p.slug == park_day_slug}.first
  end

  after_create :generate_trip_slug, :add_park_days 
  private 

  def generate_trip_slug
    unless self.name.blank?
      self.slug = self.name.downcase.gsub(" ","-").gsub("'","").gsub("&","-n-").gsub("/","-")
    end
    save
  end

  def add_park_days
    if self.start_date and self.end_date
      (self.start_date .. self.end_date).each do |d|
        pd = ParkDay.new(:date => d,
                         :slug => d.strftime("%b %d").downcase.gsub(" ", ""))

        pd.add_park_details

        self.park_days << pd
      end
    end
    save
  end

  class << self
    def find_by_slug(slug)
      first(:conditions => {:slug => slug})
    end
  end
end
