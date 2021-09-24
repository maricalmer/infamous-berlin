class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :slug, uniqueness: true, case_sensitive: false
  validates :username, uniqueness: true, case_sensitive: false, presence: true

  after_create :update_slug
  before_update :assign_slug

  has_many :projects
  has_many :inquiries
  has_many :messages, dependent: :destroy
  has_many :authored_chatrooms, class_name: 'Chatroom', foreign_key: 'author_id'
  has_many :received_chatrooms, class_name: 'Chatroom', foreign_key: 'received_id'
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_username_and_bio, against: {
    username: "A",
    bio: "B"
  }, using: {
    tsearch: { prefix: true, any_word: true }
  }
  # has_many :applications

  # APPLY
  # has_many :applying_relationships, foreign_key: :applicant_id, class_name: 'Apply'
  # has_many :applying, through: :applying_relationships, source: :applying

  # def apply(project_id)
  #   applying_relationships.create(applying_id: project_id)
  # end

  # def unapply(project_id)
  #   applying_relationships.find_by(applying_id: project_id).destroy
  # end

  # def applied?(project_id)
  #   application = Apply.find_by(applicant_id: id, applying_id: project_id)
  #   return true if application
  # end

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
