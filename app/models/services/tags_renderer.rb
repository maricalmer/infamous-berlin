class TagsRenderer
  def initialize(set)
    @set = set
  end

  def format_tags
    return [] if @set.nil?

    @set.split.map do |word|
      word.include?("_") ? word.gsub("_", " ") : word
    end
  end
end
