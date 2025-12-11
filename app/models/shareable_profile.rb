# app/models/shareable_profile.rb
class ShareableProfile < ApplicationRecord
  belongs_to :dog
  has_many :view_logs, class_name: 'ShareProfileViewLog', dependent: :destroy

  serialize :shared_categories, coder: JSON, type: Array

  has_secure_password :access_pin, validations: false

  before_create :generate_secure_token
  before_create :set_default_expiration

  SHAREABLE_CATEGORIES = {
    'owner_details' => 'Owner Contact Information',
    'vet_details' => 'Veterinarian Details',
    'medical_info' => 'Medical Information',
    'training_commands' => 'Training Commands',
    'insurance' => 'Insurance Information'
  }.freeze

  validates :shared_categories, presence: true
  validate :categories_must_be_valid
  validate :pin_format, if: -> { access_pin.present? }

  scope :active, -> {
    where('expires_at > ? OR expires_at IS NULL', Time.current)
      .where('max_views IS NULL OR view_count < max_views')
  }

  def active?
    !expired_or_maxed?
  end

  def expired_or_maxed?
    (expires_at.present? && expires_at < Time.current) ||
    (max_views.present? && view_count >= max_views)
  end

  def increment_view!(ip_address: nil)
    transaction do
      increment!(:view_count)
      view_logs.create!(
        viewed_at: Time.current,
        ip_address: ip_address
      )
    end
  end

  def public_url
    Rails.application.routes.url_helpers.shared_dog_profile_url(
      token: token,
      host: Rails.env.production? ? ENV['APP_HOST'] : 'localhost:3000'
    )
  end

  def qr_code_svg
  require 'rqrcode'
  qr = RQRCode::QRCode.new(public_url)

  # Generate as SVG with proper viewBox
  svg = qr.as_svg(
    offset: 0,
    color: '000',
    shape_rendering: 'crispEdges',
    module_size: 6,
    standalone: true
  )

  # Add viewBox if not present
  svg.gsub('<svg ', '<svg viewBox="0 0 300 300" ')
end

  private

  def generate_secure_token
    self.token = loop do
      token = SecureRandom.urlsafe_base64(32)
      break token unless self.class.exists?(token: token)
    end
  end

  def set_default_expiration
    self.expires_at ||= 7.days.from_now
  end

  def categories_must_be_valid
    return if shared_categories.blank?

    invalid = shared_categories - SHAREABLE_CATEGORIES.keys
    if invalid.any?
      errors.add(:shared_categories, "contains invalid categories: #{invalid.join(', ')}")
    end
  end

  def pin_format
    unless access_pin.match?(/^\d{4,6}$/)
      errors.add(:access_pin, "must be 4-6 digits")
    end
  end
end
