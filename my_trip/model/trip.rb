class Trip
  include MongoMapper::Document

  key :start_date, Date
  key :end_date, Date
  key :name, String
  key :slug, String
  timestamps!

  many :park_days

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

  after_create :slugify
  after_create :add_park_days
  private 

  def slugify
    unless self.name.blank?
      self.slug = self.name.downcase.gsub(" ","-").gsub("'","").gsub("&","-n-").gsub("/","-")
    end
    save
  end

  def add_park_days
    if self.start_date and self.end_date
      (self.start_date .. self.end_date).each do |d|
        self.park_days << ParkDay.new(:date => d)
      end
    end
    save
  end
end
