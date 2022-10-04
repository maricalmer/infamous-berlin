module Slug
  def assign_slug
    self.slug = determine_class
  end

  def update_slug
    update slug: assign_slug
  end

  def determine_class
    case self.class
    when User
      create_slug(username, User)
    when Project
      create_slug(title, Project)
    end
  end

  private

  def create_slug(attribute, object)
    slug = attribute.parameterize
    object.where.not(id: id).find_by(slug: slug).nil? ? slug : slug + id.to_s
  end
end

# def create_slug
#   slug = title.parameterize
#   Project.where.not(id: id).find_by(slug: slug).nil? ? slug : slug + id.to_s
# end
