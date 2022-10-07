class SlugGenerator
  def initialize(attributes = {})
    @text = attributes[:text]
    @client = attributes[:client]
  end

  def assign_slug
    @client.slug = create_slug(@text, @client)
  end

  def update_slug
    @client.update slug: assign_slug
  end

  def to_param
    slug
  end

  private

  def create_slug(text, client)
    slug = text.parameterize
    client.class.where.not(id: client.id).find_by(slug: slug).nil? ? slug : slug + client.id.to_s
  end
end
