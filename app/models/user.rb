class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :confirmable, :recoverable

  has_many :projects
  has_many :collabs
  has_many :member_projects, class_name: 'Project', through: :collabs, source: :project
  has_many :mirrors, dependent: :destroy
  has_many :inquiries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :authored_chatrooms, class_name: 'Chatroom', foreign_key: 'author_id'
  has_many :received_chatrooms, class_name: 'Chatroom', foreign_key: 'receiver_id'
  has_one_attached :photo

  validates :slug, uniqueness: true, case_sensitive: false
  validates :username, uniqueness: true, case_sensitive: false, presence: true
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }, unless: proc { |a| a.password.nil? }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :photo, size: { less_than: 5.megabytes, message: '5MB max' }

  after_create :renew_slug
  before_update :set_slug
  after_create :send_confirmation_email
  after_commit :add_default_img, on: [:create]

  include PgSearch::Model
  require "workflows/user_context"
  require "services/slug_generator"

  pg_search_scope :search_by_username_bio_skills_title, against: {
    username: "A",
    skills: "A",
    title: "A",
    bio: "B"
  }, using: {
    tsearch: {
      prefix: true,
      any_word: true
    }
  }

  def set_slug
    SlugGenerator.new(text: username, client: self).assign_slug
  end

  def renew_slug
    SlugGenerator.new(text: username, client: self).update_slug
  end

  def to_param
    slug
  end

  def contact_info?
    UserContext.new(self).contact_info?
  end

  def unread_messages?
    UserContext.new(self).unread_messages?
  end

  def default_profile_pic?
    UserContext.new(self).default_profile_pic?
  end

  def self.list_completed_profiles_only
    UserContext.new.completed_profiles
  end

  private

  def send_confirmation_email
    send_confirmation_instructions
  end

  def add_default_img
    UserContext.new(self).add_default_img
  end
end
