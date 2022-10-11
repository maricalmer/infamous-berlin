class SkillsRenderer
  def initialize(skills)
    @skills = skills
  end

  def format_skills
    return [] if @skills.nil?

    @skills.split.map do |skill|
      skill.include?("_") ? skill.gsub("_", " ") : skill
    end
  end
end
