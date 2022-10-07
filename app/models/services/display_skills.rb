module DisplaySkills
  def display_skills
    instance_of?(User) ? format_skills(skills) : format_skills(skills_needed)
  end

  private

  def format_skills(attributes)
    return [] if attributes.nil?

    attributes.split.map do |skill|
      skill.include?("_") ? skill.gsub("_", " ") : skill
    end
  end
end
