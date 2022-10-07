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

  require 'services/autocomplete_generator'
  require 'services/slug_generator'
  require 'services/skills_renderer'
  include PgSearch::Model

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

  # def render_search_skill(query)
  #   skills.split.select { |skill| skill.downcase.include?(query.downcase) }.first(5)
  # end

  def self.autocomplete_skills
    AutocompleteGenerator.new.skill_set
  end

  def self.autocomplete_usernames
    AutocompleteGenerator.new.usernames
  end

  def set_slug
    SlugGenerator.new(text: username, client: self).assign_slug
  end

  def renew_slug
    SlugGenerator.new(text: username, client: self).update_slug
  end

  def display_skills
    SkillsRenderer.new(skills).format_skills
  end

  def contact_info?
    website.present? ||
      facebook.present? ||
      instagram.present? ||
      soundcloud.present? ||
      youtube.present? ||
      mixcloud.present? ||
      linkedin.present? ||
      twitter.present?
  end

  def unread_messages?
    chatrooms = Chatroom.where(author_id: self).or(Chatroom.where(receiver_id: self))
    Message.where(read_by_receiver: false).where.not(user: self).where(chatroom: chatrooms).any?
  end

  def default_profile_pic?
    photo.filename.to_s == 'default-profile-peep.png'
  end

  def self.completed_profiles
    User.joins(:photo_blob)
        .where.not(active_storage_blobs: { filename: "default-profile-peep.png" })
        .where.not(bio: ["", nil])
  end

  private

  def send_confirmation_email
    send_confirmation_instructions
  end

  def add_default_img
    return if photo.attached?

    photo.attach(
      io: File.open(Rails.root.join("app", "assets", "images", "default-profile-peep.png")),
      filename: 'default-profile-peep.png',
      content_type: "image/png"
    )
  end
end
