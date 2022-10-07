module Slug
  def assign_slug
    self.slug = determine_class
  end

  def update_slug
    update slug: assign_slug
  end

  def determine_class
    instance_of?(User) ? create_slug(username, User) : create_slug(title, Project)
  end

  def to_param
    slug
  end

  private

  def create_slug(attribute, object)
    slug = attribute.parameterize
    object.where.not(id: id).find_by(slug: slug).nil? ? slug : slug + id.to_s
  end
end
