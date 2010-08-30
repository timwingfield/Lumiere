class ParkDay 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, :type => Date
  field :slug, :type => String

  embeds_many :park_details
  embeds_many :my_park_choices
  embeds_many :meals
  embedded_in :trip, :inverse_of => :park_days

  def to_s
    self.date.strftime("%b %d")
  end

  def find_meal_by_name(name)
    self.meals.find_all {|m| m.name == name}.first
  end

  def find_park_detail_by_abbr(abbr)
    self.park_details.find_all {|d| d.abbr == abbr}.first
  end

  def save_meal(meal)
    m = find_meal_by_name(meal.name)
    m.destroy if m != nil
    
    self.meals << meal
    meal.save
  end

  def save_park_choice(time_of_day, park_abbr)
    times = {"Morning" => {"arrive" => "9", "depart" => "12"}, 
          "Afternoon" => {"arrive" => "12", "depart" => "5"},
          "Evening" => {"arrive" => "5", "depart" => "9"}}

    arrive = times[time_of_day]["arrive"]
    depart = times[time_of_day]["depart"]

    choice = MyParkChoice.new(
                :name => time_of_day,
                :park_abbr => park_abbr,
                :arrive => arrive,
                :depart => depart)

    self.my_park_choices << choice
    choice.save
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

  after_create :slugify

  private

  def slugify
    self.slug = self.date.strftime("%b %d").downcase.gsub(" ", "")
    save
  end
end
