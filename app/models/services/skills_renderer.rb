class SkillsRenderer
  def initialize(skills)
    @skills = skills
  end

  # def display_skills
  #   instance_of?(User) ? format_skills(skills) : format_skills(skills_needed)
  # end

  # private

  def format_skills
    return [] if @skills.nil?

    @skills.split.map do |skill|
      skill.include?("_") ? skill.gsub("_", " ") : skill
    end
  end
end
