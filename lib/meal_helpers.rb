module MealHelpers
  def self.format_for_park_day(meal)
    return "" if meal == nil

    html = "<ul>"
    html << "<li>#{meal.meal_type.gsub("_", " ").capitalize}</li>"
    html << "<li>Time: #{meal.time}</li>"

    # Meal.send("#{meal.meal_type}_fields".to_sym).each do |field|
    #   value = meal.read_attribute(field.to_sym)

    #   html << "<li>"
    #   html << "<span>#{field.gsub("_", " ").capitalize}: </span>"
    #   html << "<span>#{value}</span>"
    #   html << "</li>"
    # end

    html << "<li>Notes: #{meal.notes}</li>"
    html << "</ul>"
  end
end
