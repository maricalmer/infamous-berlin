class SlugGenerator
  def initialize(attributes = {})
    @string = attributes[:string]
    @client = attributes[:client]
  end

  def assign_slug
    @client.slug = create_slug(@string, @client)
  end

  def update_slug
    @client.update slug: assign_slug
  end

  def to_param
    slug
  end

  private

  def create_slug(string, client)
    slug = string.parameterize
    client.class.where.not(id: client.id).find_by(slug: slug).nil? ? slug : slug + client.id.to_s
  end
end
