class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :slug, uniqueness: true, case_sensitive: false
  validates :username, uniqueness: true, case_sensitive: false, presence: true

  after_create :update_slug
  before_update :assign_slug

  def create_slug
    slug = self.username.parameterize
    User.where.not(id: self.id).find_by(slug: slug).nil? ? slug : slug + slug.length.to_s
  end

  def update_slug
    update slug: assign_slug
  end

  def to_param
    slug
  end

  private

  def assign_slug
    self.slug = create_slug
  end
end
